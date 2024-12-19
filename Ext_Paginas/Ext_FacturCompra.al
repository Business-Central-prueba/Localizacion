
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
            //Visible = not esBoletaHonorarios;

        }

        modify("Posting Date")
        {
            Editable = not esBoletaHonorarios;
            //Visible = not esBoletaHonorarios;

        }
        modify("VAT reporting Date")
        {
            Editable = not esBoletaHonorarios;
            //Visible = not esBoletaHonorarios;

        }
        modify("Due Date")
        {
            Editable = not esBoletaHonorarios;
            //Visible = not esBoletaHonorarios;

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
                            CurrPage.PurchLines.PAGE.SetEsBoletaHonorarios(true, true);
                            CurrPage.Update(true);
                        end
                        else begin
                            esBoletaHonorarios := false;
                            CurrPage.PurchLines.PAGE.SetEsBoletaHonorarios(false, true);
                            CurrPage.Update(true);
                        end;
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

        addbefore("Invoice Details")
        {
            group("Boleta de Honorarios")
            {
                Visible = esBoletaHonorarios;
                group("")
                {
                    field(RetencionPlusBase; Rec."Retención + base")
                    {
                        ApplicationArea = All;
                        Caption = 'Retención incl.';
                        ToolTip = 'Localización Chilena. Monto bruto. (Líquido + retención.)';
                        Editable = false;
                    }
                    field(Retencion; Rec."Retención")
                    {
                        ApplicationArea = All;
                        Caption = 'Retención'; // Cambia el nombre del campo según sea necesario
                        ToolTip = 'Localización Chilena. Monto de retención.';
                        Editable = false; // Permitir edición

                    }
                    field(MontoLiquido; Rec."Monto Liquido")
                    {
                        ApplicationArea = All;
                        Caption = 'Monto líquido';
                        ToolTip = 'Localización Chilena. Monto líquido.';
                        Editable = false;
                        trigger OnValidate()
                        var
                            PurchLine: Record "Purchase Line";
                        begin
                            if PurchLine.Get(Rec."No.") then begin
                                PurchLine.SetRange("Document No.", Rec."No.");
                                PurchLine.ModifyAll("Monto Liquido", Rec."Monto Liquido");
                                PurchLine.ModifyAll("Retención", Rec."Retención");
                                PurchLine.ModifyAll("Retención %", Rec."Retención %");
                                PurchLine.ModifyAll("Retención + base", Rec."Retención + base");
                            end;
                        end;
                    }
                    field(retencionPorc; Rec."Retención %")
                    {
                        ApplicationArea = All;
                        Caption = '% Impuesto retenido';
                        ToolTip = 'Localización Chilena. Porcentaje de retención.';
                        DecimalPlaces = 0 : 5;
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                PurchInvoiceValidation: Codeunit "CustomPurchPostHandler";
            begin
                PurchInvoiceValidation.ValidatePurchaseLines(Rec, esBoletaHonorarios);
            end;
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                PurchInvoiceValidation: Codeunit "CustomPurchPostHandler";
            begin
                PurchInvoiceValidation.ValidatePurchaseLines(Rec, esBoletaHonorarios);
            end;
        }

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
                Visible = false;
                Enabled = false;

                trigger OnAction()
                begin
                    Page.Run(Page::"API Config Lookup");
                end;
            }
        }

    }
    trigger OnOpenPage()

    begin
        if (UpperCase(Rec.DTE) = 'BOLETA DE HONORARIOS ELECT.') then begin
            esBoletaHonorarios := true;
            CurrPage.PurchLines.PAGE.SetEsBoletaHonorarios(true, false);
            CurrPage.Update(true);
        end else begin
            esBoletaHonorarios := false;
        end;
        mostrarTransportistas := true;

    end;

    var
        esBoletaHonorarios: Boolean;
        mostrarTransportistas: Boolean;


}