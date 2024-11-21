pageextension 50128 "Page Ext. Folio Venta" extends "Sales Invoice"
{
    layout
    {

        // Configura el campo "Posting Date"
        modify("Posting Date")
        {
            Editable = true;

            trigger OnBeforeValidate()
            var
                CurrentDate: Date;
            begin

                CurrentDate := Today();

                if Rec."Posting Date" <> CurrentDate then begin
                    Message('La fecha de divisas es distinta a la fecha de registro. Utilice la acción "Seleccionar Fecha" para ajustar la fecha.');
                    // El mensaje informa al usuario, pero no realiza la acción automáticamente
                    // La acción "Seleccionar Fecha" debe ser ejecutada manualmente por el usuario
                end;
            end;

        }


        addfirst(General)
        {
            field(Folio; Rec.Folio)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Número de folio de venta';
                Caption = 'N° Folio';
                Editable = false; // Campo solo de visualización
            }

            field(codigoActividad; Rec.codigoActividad)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Actividad económica';
                Caption = 'Actividad económica';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record actividadEconomica;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Actividades Económicas", ItemRec) = Action::LookupOK then
                        Rec.codigoActividad := ItemRec.nombre_Actividad;
                end;
            }

            field(listFormaPago; Rec.listFormaPago)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Lista de forma de pago';
                Caption = 'Forma de pago';
            }

            field(Id_Transaccion; Rec.Id_Transaccion)
            {
                ApplicationArea = All;
                Caption = 'Tipo de transacción';
                ToolTip = 'Localización Chilena. Tipo de transacción';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoTransaccion;
                    id: Text[30];
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Transacciones", ItemRec) = Action::LookupOK then
                        Rec.Id_Transaccion := ItemRec.descripcionTransaccion;
                end;
            }

            field(DTE; Rec.DTE)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Documento Tributario Electrónico';
                Caption = 'DTE';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoDocumentos;
                    Ndte: Code[60];
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Documentos", ItemRec) = Action::LookupOK then
                        Rec.DTE := ItemRec.Tipo;
                    Ndte := ItemRec.DTE;

                end;
            }


        }
        addlast("Sell-to")
        {
            field(Comuna; Rec."Sell-to County")
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Comuna';
                Caption = 'Comuna';

            }
            group(PDFviewer)
            {
                field(PDF; Rec."Blob PDF")
                {
                    Caption = 'Large Text';
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Codigo base64 pdf';
                    Editable = true;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        SetLargeText(LargeText);
                    end;
                }
            }
        }

        addlast(General)
        {
            field(Transportista; Rec.Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Transportista';
                Caption = 'Escoger Transportista';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record "Shipping Agent";
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Shipping Agents", ItemRec) = Action::LookupOK then
                        Rec.Transportista := ItemRec.Name;
                end;
            }

            field(rutTransportista; Rec.RUT_Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. RUT del transportista';
                Caption = 'RUT Transportista';
            }

            field(DV; Rec.DV)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Dígito verificador del RUT del transportista';
            }

            field(patenteTransportista; Rec.patenteTransportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Patente del transportista';
                Caption = 'Patente transportista';
            }

            field(Sucursal; Rec.Sucursal)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Sucursal';
                Caption = 'Sucursal';
            }
        }
        addlast("Invoice Details")
        {

        }


        addfirst(FactBoxes)
        {
            part(DocumentoPDF; "descarga pdf")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }

    }


    actions
    {
        addfirst(Processing)
        {
            action("Configurar API")
            {
                ApplicationArea = All;
                Caption = 'Configurar API';
                ToolTip = 'Abrir la página de configuración de la API';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Page.Run(Page::"API Configuration Page");
                end;
            }

            action("Enviar SII")
            {
                ApplicationArea = All;
                Caption = 'Enviar SII';
                ToolTip = 'Enviar la factura al SII';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HaulmerFactura: Codeunit "HaulmerAPI factura";
                    HaulmerFacturaExt: Codeunit "HaulmerAPI Factura Ext";
                    ConfirmSend: Boolean;
                    DTEcode: text[20];
                begin
                    ConfirmSend := Confirm('¿Realmente desea emitir factura?', false);
                    if ConfirmSend then begin
                        if Rec.DTE = uppercase('Factura electrónica') then
                            DTECode := 'FE'
                        else if Rec.DTE = UpperCase('Factura no afecta o exenta electrónica') then
                            DTECode := 'FEE'
                        else
                            Error('debe Seleccionar un DTE de la tabla Tipos documentos.');
                        case DTECode of
                            'FE':
                                begin
                                    // Acción específica para DTE 33
                                    HaulmerFactura.FacturaTipoDTE33(
                                        Rec.DTE,
                                        Rec.listFormaPago,
                                        Rec.Id_Transaccion,
                                        Rec."Bill-to Name",
                                        Rec."No.",
                                        Rec.codigoActividad,
                                        Rec."Sell-to Address",
                                        Rec."Sell-to County",
                                        Rec.Folio,
                                        Rec."Prices Including VAT",
                                        Rec."Sell-to Customer Name",
                                        rec."Currency Code",
                                        Rec."Posting Date"

                                    );
                                end;
                            'FEE':
                                begin
                                    // Acción específica para DTE 34
                                    HaulmerFacturaExt.FacturaTipoDTE34(
                                        Rec.DTE,
                                        Rec.listFormaPago,
                                        Rec.Id_Transaccion,
                                        Rec."Bill-to Name",
                                        Rec."No.",
                                        Rec.codigoActividad,
                                        Rec."Sell-to Address",
                                        Rec."Sell-to County",
                                        Rec.Folio,
                                        Rec."Prices Including VAT",
                                        Rec."Sell-to Customer Name"
                                    );
                                    // Aquí puedes añadir cualquier otra lógica específica para DTE 34
                                end;
                            else
                                Error('Tipo de DTE no soportado.');
                        end;
                    end;
                end;
            }

            action("Seleccionar Fecha Divisa")
            {
                ApplicationArea = All;
                Caption = 'Seleccionar Fecha';
                Image = Calendar;
                trigger OnAction()
                var
                    CurrencyExchangeRateRec: Record "Currency Exchange Rate";
                    GeneralLedgerSetupRec: Record "General Ledger Setup";
                    DateSelected: Date;
                    CurrencyCode: Code[10];
                begin
                    // Verificar si el Currency Code está vacío
                    if Rec."Currency Code" = '' then begin
                        // Obtener el LCY Code de la configuración general
                        GeneralLedgerSetupRec.Get();
                        CurrencyCode := GeneralLedgerSetupRec."LCY Code";
                    end else begin
                        // Usar el Currency Code del registro
                        CurrencyCode := Rec."Currency Code";
                    end;

                    // Establecer el rango en Currency Exchange Rate con el código de moneda determinado
                    CurrencyExchangeRateRec.SETRANGE(CurrencyExchangeRateRec."Currency Code", CurrencyCode);

                    // Ejecutar la página para seleccionar la fecha de la tasa de cambio
                    if Page.RunModal(Page::"Currency Exchange Rates", CurrencyExchangeRateRec) = Action::LookupOK then begin
                        DateSelected := CurrencyExchangeRateRec."Starting Date";
                        Rec."Posting Date" := DateSelected;
                        Rec.MODIFY(TRUE); // Guardar los cambios en el registro
                    end;
                end;
            }



        }


    }

    var
        LargeText: Text;

    trigger OnAfterGetRecord()
    begin
        LargeText := GetLargeText();
    end;

    procedure SetLargeText(NewLargeText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."Blob PDF");
        Rec."Blob PDF".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(LargeText);
        Rec.Modify();
    end;

    procedure GetLargeText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("Blob PDF");
        Rec."Blob PDF".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName("Blob PDF")));
    end;
}



