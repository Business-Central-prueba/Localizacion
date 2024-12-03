codeunit 50113 "HaulmerAPI Factura"
{
    procedure FacturaTipoDTE33(DTE: Code[20]; listFormaPago: Option; Id_Transaccion: Code[60]; "Bill-to Name": Text[100]; "No.": Code[20]; codigoactividad: code[250]; "Sell-to Address": text[100]; "Sell-to County": text[100]; Folio: integer; "Prices Including VAT": Boolean; "Sell-to Customer Name": text[300]; "Currency Code": code[300]; "Posting Date": date)
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        Headers: HttpHeaders;
        Body: Text;
        ResponseText: Text; // Usa Text para construir el Record ID
        ResponseStatus: Boolean;
        RecordId: Text; // Usa Text para construir el Record ID
        ConfigLeader: record "General Ledger Setup";

        ConfigRecord: Record "API Configuration";

        CamposEmisor: Record "Company Information";
        DatosEmisor: Record "Company Information";
        SalesHeader: Record "Sales header";
        TipoDocumentos: Record "tipoDocumentos";
        TipoDTE: Integer;
        TipoTransaccionCompra: Record "tipoTransaccion";
        tipotransaccion: Text[20];
        T_ActividadEconomica: Record "actividadEconomica";
        actividadeconomica: Text[20];

        codeunit411: Codeunit "Base64 Convert";

        RecordLink: Record "Record Link";
        LastLinkID: integer;
        pageinvoicelist: Page "sales invoice list";
        NewLinkID: integer;
        //GuardarPDFFactura: Codeunit "Guardar PDF Factura";
        SalesLine: Record "Sales Line";
        SalesLineJson: Text;
        NmbItem: Text;
        QtyItem: Decimal;
        PrcItem: Decimal;
        MontoItem: Integer;
        UdmItem: text;
        Tax: integer;
        MntNeto: Integer;
        IVA: Integer;
        MntTotal: Integer;
        MontoPeriodo: Integer;
        VlrPagar: Integer;
        NroLinDet: Integer; // Variable autoincremental

        Montototal: Decimal;
        MontosinIVa: Integer;
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        FolioFactura: Integer;
        Base64: Text;

        Token: Text;
        FechaActual: Date;
        TotalconIVA: Decimal;
        LCYCode: Code[10]; // Variable para almacenar el LCY Code

        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";

        CurrencyExchange: Record "Currency Exchange Rate";

    begin
        if "Currency Code" = 'UF' then begin
            // Validar que el Posting Date sea coherente con el Starting Date de Currency Exchange
            CurrencyExchange.SetRange("Currency Code", "Currency Code");
            CurrencyExchange.SetRange("Starting Date", "Posting Date");

            if not CurrencyExchange.FindFirst() then
                Error('La fecha de "Posting Date" no coincide con la fecha de "Starting Date" en la tabla de "Currency Exchange".');
        end;
        if ConfigRecord.FindFirst() then begin
            ConfigLeader.Get();
            LCYCode := ConfigLeader."LCY Code";

            // Validación para Currency Code vacío y LCY Code = 'CLP'
            if "Currency Code" = '' then begin
                if LCYCode = 'CLP' then
                    Message('Advertencia: El campo "Currency Code" está vacío pero se emitirá la factura usando CLP.')
                else
                    Error('El campo "Currency Code" está vacío y la moneda local no es CLP.');
            end else if "Currency Code" <> LCYCode then begin
                if "Currency Code" <> 'UF' then begin
                    Error('El código de divisa debe ser igual a la moneda local o UF. Código de divisa actual: %1', "Currency Code");
                    exit;
                end;
            end;

            if "Currency Code" = 'UF' then begin
                // Validar que el Posting Date sea coherente con el Starting Date de Currency Exchange
                CurrencyExchange.SetRange("Currency Code", "Currency Code");
                CurrencyExchange.SetRange("Starting Date", "Posting Date");

                if not CurrencyExchange.FindFirst() then
                    Error('La fecha de "Posting Date" no coincide con la fecha de "Starting Date" en la tabla de "Currency Exchange".');
            end;

            //Validar el valor del campo Folio
            if Folio > 0 then begin
                Error('El proceso de emisión no puede continuar ya tiene un folio asignado');
                exit; // Salir del procedimiento
            end;


            HttpRequestMessage.SetRequestUri('https://dev-api.haulmer.com/v2/dte/document');


            // Validaciones de campos obligatorios
            if DTE = '' then begin
                Error('El campo DTE es obligatorio para emitir la factura.');
                exit;
            end;
            if Id_Transaccion = '' then begin
                Error('El campo tipo transacción es obligatorio para emitir la factura.');
                exit;
            end;
            if codigoactividad = '' then begin
                Error('El campo codigoactividad es obligatorio para emitir la factura.');
                exit;
            end;
            if "Sell-to Address" = '' then begin
                Error('El campo "direccion" es obligatorio para emitir la factura.');
                exit;
            end;
            if "Sell-to County" = '' then begin
                Error('El campo "Sell-to County" es obligatorio para emitir la factura.');
                exit;
            end;
            if "Prices Including VAT" then begin
                Error('No se puede emitir la factura esta activo "Precios con IVA".');
                exit;
            end;

            // Filtros
            CamposEmisor.get();
            // Obtener el TipoDTE desde la tabla "tipoDocumentos" basado en el DTE del formulario
            TipoDocumentos.SetRange("Tipo", DTE);
            if TipoDocumentos.FindFirst() then begin
                if Evaluate(TipoDTE, TipoDocumentos.DTE) then begin
                    // TipoDTE ahora contiene el valor entero correspondiente
                end else begin
                    TipoDTE := 0; // Ajustar según otros casos si es necesario
                end;
            end;

            // Obtener el TipotransaccionCompra desde la tabla "tipo transaccion" basado en el tipo transacción del formulario
            TipoTransaccionCompra.SetRange("descripcionTransaccion", Id_Transaccion);
            if TipoTransaccionCompra.FindFirst() then begin
                if Evaluate(tipotransaccion, TipoTransaccionCompra.Id_Transaccion) then begin
                    // tipotransaccion ahora contiene el valor correspondiente
                end else begin
                    tipotransaccion := ''; // Ajustar según otros casos si es necesario
                end;
            end;
            // obtener el codigo de la tabla ActividadEconomica basado en el tipo de codigoactividad del formulario
            T_ActividadEconomica.SetRange(codigoactividad, codigoactividad);
            if T_ActividadEconomica.FindFirst() then begin
                if Evaluate(actividadeconomica, T_ActividadEconomica.codigoActividad) then begin

                end else begin
                    actividadeconomica := ''; // Ajustar según otros casos si es necesario
                end;
            end;

            FechaActual := Today;
            // Inicializar MntNeto y NroLinDet
            MntNeto := 0;
            SalesLineJson := '';
            SalesLine.SetRange("Document No.", "No.");
            if SalesLine.FindSet() then begin
                TAX := SalesLine."VAT %";
                NroLinDet := 1; // Inicializar NroLinDet en 1
                MontoTotal := SalesLine."Amount Including VAT";

                // Iterar sobre los registros encontrados
                repeat
                    // Captura los valores en variables
                    NmbItem := SalesLine.Description;
                    QtyItem := SalesLine.Quantity;
                    PrcItem := SalesLine."Unit Price";
                    UdmItem := SalesLine."Unit of Measure Code";

                    // Redondear MontoItem al entero más cercano
                    MontoItem := ROUND(SalesLine."Line Amount", 1, '=');
                    if MontoItem < 0 then
                        Error('El monto de la línea no puede ser negativo.');

                    // Verificar si los campos están vacíos o tienen valores inválidos
                    if NmbItem = '' then
                        Error('El campo NmbItem (Descripción) no puede estar vacío.');
                    if QtyItem = 0 then
                        Error('El campo QtyItem (Cantidad) no puede ser cero.');
                    if PrcItem = 0 then
                        Error('El campo PrcItem (Precio Unitario) no puede ser cero.');

                    // Sumar MontoItem a MntNeto
                    MntNeto += MontoItem;

                    // Construir la parte JSON del detalle para cada línea
                    if NroLinDet > 1 then
                        SalesLineJson += ',';

                    // Asegurarnos de que NroLinDet sea un entero válido y empiece en 1
                    SalesLineJson += '{' +
                                     '"NroLinDet": ' + FORMAT(NroLinDet, 0, '<Integer>') + ',' +
                                     '"NmbItem": "' + NmbItem + '",' +
                                     '"QtyItem": ' + FORMAT(ROUND(QtyItem, 1, '='), 0, '<Integer>') + ',' +
                                     '"PrcItem": ' + FORMAT(ROUND(PrcItem, 1, '='), 0, '<Integer>') + ',' +
                                     '"MontoItem": ' + FORMAT(MontoItem) + ',' +
                                     '"UnmdItem": "' + FORMAT(UdmItem) + '"' +
                                     '}';

                    // Incrementar NroLinDet
                    NroLinDet += 1;

                until SalesLine.Next() = 0;
            end;

            // Calcular IVA, MntTotal, MontoPeriodo y VlrPagar
            IVA := ROUND(MntNeto * 0.19, 1, '='); // Redondear al entero más cercano
            MntTotal := MntNeto + IVA; // Sumar para obtener el total
            MontoPeriodo := MntTotal;
            VlrPagar := MntTotal;


            // Preparar el Body de la solicitud
            Body := '{' +
                    '    "response": [' +
                    '        "PDF",' +
                    '        "FOLIO"' +
                    '    ],' +
                    '    "dte": {' +
                    '        "Encabezado": {' +
                    '            "IdDoc": {' +
                    '                "TipoDTE": ' + FORMAT(TipoDTE) + ',' +
                    '                "Folio": 0,' +
                    '                "FchEmis": "' + FORMAT(FechaActual, 0, '<Year4>-<Month,2>-<Day,2>') + '",' +
                    '                "TpoTranCompra": "' + FORMAT(tipotransaccion) + '",' +
                    '                "TpoTranVenta": "",' +
                    '                "FmaPago": "' + FORMAT(listFormaPago) + '"' +
                    '            },' +
                    '            "Emisor": {' +
                    '                "RUTEmisor": "' + FORMAT(CamposEmisor."Rut Company") + '",' +
                    '                "RznSoc": "' + FORMAT(CamposEmisor.Name) + '",' +
                    '                "GiroEmis": "' + FORMAT(CamposEmisor.codigoActividad) + '",' +
                    '                "Acteco": "620200",' +
                    '                "DirOrigen": "' + FORMAT(CamposEmisor.Address) + '",' +
                    '                "CmnaOrigen": "' + FORMAT(CamposEmisor.County) + '",' +
                    '                "Telefono": "' + FORMAT(CamposEmisor."Phone No.") + '",' +
                    '                "CdgSIISucur": "79457965"' +
                    '            },' +
                    '            "Receptor": {' +
                    '                "RUTRecep": "76430498-5",' +
                    '                "RznSocRecep": "' + FORMAT("Sell-to Customer Name") + '",' +
                    '                "GiroRecep": "' + FORMAT("codigoactividad") + '",' +
                    '                "DirRecep": "' + FORMAT("Sell-to Address") + '",' +
                    '                "CmnaRecep": "' + FORMAT("Sell-to County") + '"' +
                    '            },' +
                    '            "Totales": {' +
                    '                "MntNeto": ' + FORMAT(MntNeto) + ',' +
                    '                "TasaIVA": ' + FORMAT(Tax) + ',' +
                    '                "IVA": ' + FORMAT(IVA) + ',' +
                    '                "MntTotal": ' + FORMAT(MntTotal) + ',' +
                    '                "MontoPeriodo": ' + FORMAT(MontoPeriodo) + ',' +
                    '                "VlrPagar": ' + FORMAT(VlrPagar) +
                    '            }' +
                    '        },' +
                    '        "Detalle": [' +
                    SalesLineJson +
                    '        ]' +
                    '    }' +
                    '}';

            // Configurar el contenido de la solicitud
            HttpContent.WriteFrom(Body);
            HttpRequestMessage.Content := HttpContent;
            HttpRequestMessage.Method := 'POST';

            // Configurar los headers
            HttpRequestMessage.Content.GetHeaders(Headers);
            Headers.Clear();
            Headers.Add('Content-Type', ConfigRecord."Content-Type");
            Headers.Add('apikey', ConfigRecord.apikey);

            // Enviar la solicitud
            ResponseStatus := HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
            if HttpResponseMessage.HttpStatusCode() = 200 then begin
                HttpResponseMessage.Content.ReadAs(ResponseText);

                // Parsear la respuesta JSON
                if JsonResponse.ReadFrom(ResponseText) then begin
                    // Extraer y mostrar FOLIO
                    if JsonResponse.Get('FOLIO', JsonToken) then begin
                        FolioFactura := JsonToken.AsValue().AsInteger();

                        // Actualizar el campo Folio en SalesHeader
                        SalesHeader.SetRange("No.", "No.");
                        if SalesHeader.FindFirst() then begin
                            SalesHeader.Folio := FolioFactura;
                            SalesHeader.Modify();
                        end;

                        // Mostrar mensaje con el folio
                        Message('El folio asignado es: %1', FolioFactura);
                    end;

                    // Extraer y mostrar PDF
                    if JsonResponse.Get('PDF', JsonToken) then begin
                        Base64 := JsonToken.AsValue().AsText();
                        //Message('Base64: %1', Base64);

                        SalesHeader.SetRange("No.", "No.");
                        if SalesHeader.FindFirst() then begin
                            /*  RecordLink.SetRange("Record ID", SalesHeader.RecordId);
                              if not RecordLink.FindFirst() then begin
                                  RecordLink.Init();
                                  RecordLink."Record ID" := SalesHeader.RecordId;
                                  RecordLink."User ID" := UserId;
                                  RecordLink.Company := CompanyName;
                                  TempBlob.CreateOutStream(OutStream);
                                  OutStream.WriteText(Base64);
                                  TempBlob.CreateInStream(InStream);
                                  RecordLink.Note.CreateOutStream(OutStream);
                                  CopyStream(OutStream, InStream);
                                  RecordLink.Insert();
                                  // Mostrar mensaje de éxito al guardar el PDF
                                  Message('El PDF se ha guardado exitosamente.');
                              end;
                          end;*/
                            // OutStream para el campo Blob PDF
                            SalesHeader."Blob PDF".CreateOutStream(OutStream);
                            OutStream.WriteText(Base64);

                            // Modify the SalesHeader to save the changes
                            SalesHeader.Modify();
                            // Mostrar mensaje de éxito al guardar el PDF
                            Message('El PDF se ha almacenado exitosamente en el campo Blob PDF de tabla Sales Header.');
                        end;
                    end;

                    // Extraer y mostrar TOKEN
                    if JsonResponse.Get('TOKEN', JsonToken) then begin
                        Token := JsonToken.AsValue().AsText();
                    end else begin
                        // Mostrar mensaje si el TOKEN no se recibe
                        Message('Token no recibido en la respuesta.');
                    end;

                    // Mostrar mensaje final de éxito
                    Message('Factura emitida con folio N %1', FolioFactura);
                    Message('Factura Emitida codigo Base64 para decode %1', Base64);
                    // Mostrar el contenido de la respuesta para depuración


                end else begin
                    Error('Error al parsear la respuesta JSON.');
                end;


            end else begin

                Message('Error al enviar la solicitud:', HttpResponseMessage.HttpStatusCode());
                Message('Revisar: %1', Body);

            end;

        end else begin
            Error('No se encontró configuración de API.');
        end;

    end;

    procedure AttatchPDFDocument(var SalesHeader: Record "Sales Header")
    var
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
        DocAttach: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        Base64Text: Text;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        if SalesHeader."Blob PDF".HasValue() then begin
            FileName := 'Factura-' + Format(SalesHeader.Folio) + '.pdf';
            SalesHeader."Blob PDF".CreateInStream(InStream);
            InStream.ReadText(Base64Text);
            Message('Base64Text: %1', Base64Text);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(Base64Text, OutStream);
            TempBlob.CreateInStream(InStream);
            //Message('InStream: ', InStream);
            DocAttach.Init();
            DocAttach.Validate("Table ID", Database::"Sales Header");
            DocAttach.Validate("Document Type", Enum::"Sales Document Type"::Order);
            DocAttach.Validate("No.", SalesHeader."No.");
            Message('D att No: ' + Format(DocAttach."No."));
            Message('S head No: ' + Format(SalesHeader."No."));
            DocAttach.Validate("File Name", FileName);
            Message('File Name: ' + DocAttach."File Name");
            DocAttach.Validate("File Extension", 'pdf');
            Message('File Extension: ' + DocAttach."File Extension");
            DocAttach."Document Reference ID".ImportStream(InStream, FileName);
            if not DocAttach.HasContent() then begin
                Message('No se pudo adjuntar el documento PDF.');
            end else begin
                DocAttach.Insert(true);
                Message('Documento PDF adjunto correctamente en ID: %1' + Format(DocAttach."No.") + ' con el ID: ' + Format(DocAttach."Document Reference ID"));
            end;
        end else begin
            Message('No se encontró un documento PDF para adjuntar.');
        end;
    end;
}

