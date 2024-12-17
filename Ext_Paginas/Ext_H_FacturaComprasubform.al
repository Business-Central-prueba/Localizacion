pageextension 50667 Ext_H_FacturaCompra_subform extends "Posted Purch. Invoice Subform"
{

    // Agregar un nuevo campo en el grupo existente
    layout
    {
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                directUnitCost: Decimal;
                vatPercentage: Decimal;
                retencionPercentage: Decimal;
                boletaHonorario: Codeunit 50110; // Instancia del codeunit
                                                 //purchaseInvoiceRec: Record "Purch. Invoice"; // Declarar el registro de la factura de compra
            begin
                // Verificar si el DTE es igual a "boletahonorario"
                //if Rec."DTE" = 'boletahonorario' then begin // Asegúrate de que "DTE" sea el nombre correcto del campo
                directUnitCost := Rec."Direct Unit Cost"; // Obtener el nuevo valor de "Direct Unit Cost"
                vatPercentage := Rec."VAT %";
                retencionPercentage := Rec."Retención %"; // Asegúrate de que "VAT %" sea el nombre correcto del campo
                // Llamar al codeunit para realizar la lógica adicional
                boletaHonorario.CalculateRetention(
                    directUnitCost,
                    Rec."Retención",
                    Rec."Retención + base",
                    retencionPercentage
                );
            end;
            //end;
        }

        // Asegúrate de que el nuevo campo se agregue en el mismo grupo que los campos existentes


        addafter(Control7)
        {
            group("Boleta Honorarios")
            {
                Visible = EsBoletaHonorarios;
                field(Probando; Rec."Monto Liquido")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monto líquido';
                    ToolTip = 'Localización Chilena. Monto líquido.';
                    Editable = false;
                }
                field(REtencion; rec."Retención")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retención'; // Cambia el nombre del campo según sea necesario
                    ToolTip = 'Localización Chilena. Monto de retención.';
                    Editable = false; // Permitir edición
                    Visible = true;
                }
                field(REtencionplusbase; rec."Retención + base")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retención incl.';
                    ToolTip = 'Localización Chilena. Monto bruto. (Líquido + retención.)';
                    Editable = false;
                    Visible = true;
                }

                field(vatPercentage; Rec."Retención %")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '% Impuesto retenido';
                    ToolTip = 'Localización Chilena. Porcentaje de retención.';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = true;
                }
            }
        }

        modify(Control25) // Este es el grupo donde están los campos existentes
        {
            Visible = not EsBoletaHonorarios;
        }

        modify(Control7) // Este es el grupo donde están los campos existentes
        {
            Visible = not EsBoletaHonorarios;
        }
    }

    procedure SetEsBoletaHonorarios(Value: Boolean; Picked: Boolean)
    begin
        EsBoletaHonorarios := Value;
    end;

    var
        EsBoletaHonorarios: Boolean;
}

