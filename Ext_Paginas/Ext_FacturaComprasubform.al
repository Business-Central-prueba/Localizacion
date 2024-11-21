pageextension 50666 Ext_FacturaCompra_subform extends "Purch. Invoice Subform"
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
                boletaHonorario: Codeunit 50110; // Instancia del codeunit
                                                 //purchaseInvoiceRec: Record "Purch. Invoice"; // Declarar el registro de la factura de compra
            begin
                // Verificar si el DTE es igual a "boletahonorario"
                //if Rec."DTE" = 'boletahonorario' then begin // Asegúrate de que "DTE" sea el nombre correcto del campo
                directUnitCost := Rec."Direct Unit Cost"; // Obtener el nuevo valor de "Direct Unit Cost"
                vatPercentage := Rec."VAT %"; // Asegúrate de que "VAT %" sea el nombre correcto del campo
                // Llamar al codeunit para realizar la lógica adicional
                boletaHonorario.CalculateRetention(
                    directUnitCost,
                    Rec."Retención",
                    Rec."Retención + base",
                    vatPercentage
                );
            end;
            //end;
        }

        // Asegúrate de que el nuevo campo se agregue en el mismo grupo que los campos existentes
        addlast(Control15) // Este es el grupo donde están los campos existentes
        {
            field(REtencion; rec."Retención")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retención'; // Cambia el nombre del campo según sea necesario
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false; // Permitir edición
                // Puedes agregar más propiedades según sea necesario
            }
            field(REtencionplusbase; rec."Retención + base")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retención incl.';
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false;

                // Lógica para calcular el valor
                trigger OnValidate()
                var
                    directUnitCost: Decimal;
                begin
                    directUnitCost := rec."Direct Unit Cost"; // Obtener el valor de "Direct Unit Cost"
                    rec."Retención + base" := directUnitCost + 1; // Sumar 1
                end;
            }

            field(vatPercentage; Rec."VAT %")
            {
                ApplicationArea = Basic, Suite;
                Caption = '% Impuesto retenido'; // Cambia el nombre del campo según sea necesario
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false; // Permitir edición
                // Puedes agregar más propiedades según sea necesario
            }

        }
    }

}