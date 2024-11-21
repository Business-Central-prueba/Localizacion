
//Verificar bien si el ID no está utilizado por otra entidad

pageextension 50127 "Page Ext. Folio Compra" extends "Purchase Invoice"
{

    layout
    {
        //campos heredados de purchase invoice
        modify("Foreign Trade")
        {
            Visible = not esBoletaHonorarios;
        }

        modify("Shipping and Payment")
        {
            Visible = not esBoletaHonorarios;
        }

        modify("Document Date")
        {
            Editable = not esBoletaHonorarios;
            Visible = not esBoletaHonorarios;

        }

        modify("Posting Date")
        {
            Editable = not esBoletaHonorarios;
            Visible = not esBoletaHonorarios;

        }
        modify("VAT reporting Date")
        {
            Editable = not esBoletaHonorarios;
            Visible = not esBoletaHonorarios;

        }
        modify("Due Date")
        {
            Editable = not esBoletaHonorarios;
            Visible = not esBoletaHonorarios;

        }


        addfirst(General)
        {

            field(Folio; Rec.Folio)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Número de folio de compra';
                Caption = 'N° Folio';
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

            field(Id; Rec.Id_Transaccion)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Tipo de transacción';
                Caption = 'Tipo de transacción';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoTransaccion;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Transacciones", ItemRec) = Action::LookupOK then
                        Rec.Id_Transaccion := ItemRec.descripcionTransaccion;
                end;
            }

            field(DTE; Rec.DTE)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Documento Tributario Electrónico (DTE)';
                Caption = 'DTE';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoDocumentos;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Documentos", ItemRec) = Action::LookupOK then begin
                        Rec.DTE := ItemRec.Tipo;
                        if (Rec.DTE = 'BOLETA DE HONORARIOS ELECT.') or (Rec.DTE = 'Boleta de honorarios elect.') then begin
                            esBoletaHonorarios := true;
                            //CurrPage.Update(false);
                        end
                        else begin
                            esBoletaHonorarios := false;
                        end;
                        /*
                        Rec.Modify(true);
                       */
                        //CurrPage.Update(false);
                    end;

                end;

            }


        }

        addlast(General)
        {
            group("Transportista Information")
            {
                ShowCaption = false; // Oculta el título del grupo si no lo necesitas
                Visible = not esBoletaHonorarios;

                field(Transportistas; Rec.Transportistas)
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
                            Rec.Transportistas := ItemRec.Name;
                    end;
                }

                field(rutTransportista; Rec.RUT_Transportista)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. RUT de transportista';
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
                    ToolTip = 'Localización Chilena. Patente de transportista';
                    Caption = 'Patente de transportista';
                    Visible = not esBoletaHonorarios;
                }

                field(Sucursal; Rec.Sucursal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Sucursal';
                    Caption = 'Sucursal';
                    Visible = not esBoletaHonorarios;
                }



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
                    Page.Run(Page::"API Config Lookup");
                end;
            }
        }
    }
    trigger OnOpenPage()

    begin
        esBoletaHonorarios := false;
        mostrarTransportistas := true;

    end;

    var
        esBoletaHonorarios: Boolean;
        mostrarTransportistas: Boolean;


}