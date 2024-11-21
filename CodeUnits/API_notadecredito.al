codeunit 50119 "HaulmerAPI Notadecredito"
{
    procedure FacturaTipoDTE61(DTE: Code[20]; listFormaPago: Option; Id_Transaccion: Code[60]; "Bill-to Name": Text[100]; "No.": Code[20]; codigoactividad: code[250]; "Sell-to Address": text[100]; "Sell-to County": text[100]; Folio: integer; "Prices Including VAT": Boolean; "Sell-to Customer Name": text[300]; "Currency Code": code[300]; "Posting Date": date)
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        Headers: HttpHeaders;
        Body: Text;
        ResponseText: Text;
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

        RecordLink: Record "Record Link";
        LastLinkID: integer;
        NewLinkID: integer;

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

        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        FolioFactura: Integer;
        Base64: Text;

        Token: Text;
        FechaActual: Date;

        TotalconIVA: Decimal;
        LCYCode: Code[10]; // Variable para almacenar el LCY Code
        Saleslineinvoice: Record "Sales Invoice Line";

        CurrencyExchange: Record "Currency Exchange Rate";
    begin
        // Validación cuando el "Currency Code" es 'UF'


        // Obtener la configuración de la API del primer registro
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

            // //Validar el valor del campo Folio
            // if Folio > 0 then begin
            //     Error('El proceso de emisión no puede continuar ya tiene un folio asignado');
            //     exit; // Salir del procedimiento
            // end;


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
            NroLinDet := 1;
            SalesLineJson := '';

            // Preparar los datos de detalle
            Saleslineinvoice.SetRange("Document No.", "No.");
            if Saleslineinvoice.FindSet() then begin
                TAX := Saleslineinvoice."VAT %";
                TotalconIVA := Saleslineinvoice."Amount Including VAT";


                // Iterar sobre los registros encontrados
                repeat
                    // Captura los valores en variables
                    NmbItem := Saleslineinvoice.Description;
                    QtyItem := Saleslineinvoice.Quantity;
                    PrcItem := Saleslineinvoice."Unit Price";
                    UdmItem := Saleslineinvoice."Unit of Measure Code";
                    MontoItem := Saleslineinvoice."Line Amount" DIV 1;

                    if NmbItem = '' then
                        Error('El campo NmbItem (Descripción) no puede estar vacío.');
                    if QtyItem = 0 then
                        Error('El campo QtyItem (Cantidad) no puede ser cero.');
                    if PrcItem = 0 then
                        Error('El campo PrcItem (Precio Unitario) no puede ser cero.');

                    if Evaluate(UdmItem, Saleslineinvoice."Unit of Measure Code") then begin
                    end;



                    // Sumar MontoItem a MntNeto
                    MntNeto += MontoItem;

                    // Construir la parte JSON del detalle para cada línea
                    if NroLinDet > 1 then
                        SalesLineJson += ',';

                    SalesLineJson += '{' +
                                     '"NroLinDet": ' + FORMAT(NroLinDet) + ',' +
                                     '"NmbItem": "' + NmbItem + '",' +
                                     '"QtyItem": ' + FORMAT(QtyItem, 0, '<Integer>') + ',' +
                                     '"PrcItem": ' + FORMAT(PrcItem, 0, '<Integer>') + ',' +
                                     '"MontoItem": ' + FORMAT(MontoItem) + ',' +
                                     '"UnmdItem": "' + FORMAT(UdmItem) + '"' +
                                     '}';


                    // Incrementar NroLinDet
                    NroLinDet += 1;

                until Saleslineinvoice.Next() = 0;
            end;


            // Calcular IVA, MntTotal, MontoPeriodo y VlrPagar
            IVA := ROUND(MntNeto * 0.19, 1, '=');
            MntTotal := ROUND(MntNeto * 1.19, 1, '=');
            MontoPeriodo := MntTotal;
            VlrPagar := MntTotal;

            // Preparar el Body de la solicitud
            Body := '{' +
         '    "response": [' +
         '        "PDF",' +
         '        "FOLIO",' +
         '        "RESOLUCION"' +
         '    ],' +
         '    "dte": {' +
         '        "Encabezado": {' +
         '            "IdDoc": {' +
         '                "TipoDTE": 61,' +
         '                "Folio":  0,' + // Cambiar a Folio actual
         '                "FchEmis": "' + FORMAT(FechaActual, 0, '<Year4>-<Month,2>-<Day,2>') + '",' +
         '                "TpoTranVenta": "1",' + // Valor fijo, ajustar si necesario
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
         '        ],' +
         '        "Referencia": [' +
         '            {' +
         '                "NroLinRef": 1,' +
         '                "TpoDocRef":' + FORMAT(TipoDTE) + ',' +
         '                "FolioRef":' + FORMAT(Folio) + ',' +
         '                "FchRef": "' + FORMAT(FechaActual, 0, '<Year4>-<Month,2>-<Day,2>') + '",' +
         '                "CodRef": "3"' + // Cambiar si es necesario
         '            }' +
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
                // Extraer y mostrar FOLIO
                if JsonResponse.Get('FOLIO', JsonToken) then begin
                    FolioFactura := JsonToken.AsValue().AsInteger();
                    // Aquí debes encontrar y actualizar el registro de la factura en la base de datos
                    // Actualizar el campo Folio con el valor recibido
                    SalesHeader.SetRange("No.", "No.");
                    if SalesHeader.FindFirst() then begin
                        Folio := FolioFactura;
                        SalesHeader.Folio := Folio;
                        SalesHeader.Modify;
                    end;
                end;
                //Extraer y mostrar PDF
                if JsonResponse.Get('PDF', JsonToken) then begin
                    Base64 := JsonToken.AsValue().AsText();

                    //  Convertir el texto del PDF a un blob

                    //Obtener el SalesHeader
                end;
                //Extraer y mostrar TOKEN
                if JsonResponse.Get('TOKEN', JsonToken) then begin
                    Token := JsonToken.AsValue().AsText();
                end else begin

                    Message(ResponseText);
                end;

            end else begin
                Message('Error al enviar la solicitud por favor,actualize la pagina y reintente   %1', HttpResponseMessage.HttpStatusCode());
            end;

        end else begin
            Message('No se encontró configuración de API.');
        end;
    end;
}
