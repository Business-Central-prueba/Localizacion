pageextension 50133 "extend sales invoice posted" extends "Posted Sales Invoice"
{
    layout
    {
        modify(Cancelled)
        {
            Visible = true;
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
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Documentos", ItemRec) = Action::LookupOK then
                        Rec.DTE := ItemRec.Tipo;
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

            field(PDF; Rec."Blob PDF")
            {
                ApplicationArea = All;
                ToolTip = 'codigo PDF';
                Caption = 'PDF';
                Editable = true;
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
                begin
                    ConfirmSend := Confirm('¿Realmente desea emitir factura?', false);
                    if ConfirmSend then begin
                        case Rec.DTE of
                            '33':
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
                                        Rec."Currency Code",
                                        Rec."Posting Date"
                                    );
                                    // Aquí puedes añadir cualquier otra lógica específica para DTE 33
                                end;
                            '34':
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

            action(CustomCancelInvoice)
            {
                ApplicationArea = All;
                Caption = 'Anular SII';
                ToolTip = 'Anular la factura en el SII';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Cancel;

                trigger OnAction()
                var
                    HaulmerFactura: Codeunit "HaulmerAPI Notadecredito";
                    ConfirmSend: Boolean;
                    CancelPstdSalesInvYesNo: Codeunit "Cancel PstdSalesInv (Yes/No)";
                begin
                    ConfirmSend := Confirm('¿Realmente desea cancelar la factura?', false);
                    if ConfirmSend then begin
                        // Ejecutar la lógica personalizada de cancelación
                        HaulmerFactura.FacturaTipoDTE61(
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
                            Rec."Currency Code",
                            Rec."Posting Date"
                        );

                        // Ejecutar la lógica de cancelación estándar
                        if CancelPstdSalesInvYesNo.CancelInvoice(Rec) then
                            CurrPage.Close();
                    end;
                end;
            }
        }
    }


}