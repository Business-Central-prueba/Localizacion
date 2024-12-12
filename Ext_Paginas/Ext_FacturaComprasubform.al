pageextension 50666 Ext_FacturaCompra_subform extends "Purch. Invoice Subform"
{

    // Agregar un nuevo campo en el grupo existente
    layout
    {
        modify("Direct Unit Cost")
        {
            Editable = false;
            trigger OnAfterValidate()
            var
                directUnitCost: Decimal;
                vatPercentage: Decimal;
                boletaHonorario: Codeunit 50110; // Instancia del codeunit
                                                 //purchaseInvoiceRec: Record "Purch. Invoice"; // Declarar el registro de la factura de compra
            begin
                // Verificar si el DTE es igual a "boletahonorario"
                //if Rec."DTE" = 'boletahonorario' then begin // Asegúrate de que "DTE" sea el nombre correcto del campo
                directUnitCost := Rec."Monto Liquido"; // Obtener el nuevo valor de "Direct Unit Cost"
                //vatPercentage := Rec."VAT %"; // Asegúrate de que "VAT %" sea el nombre correcto del campo
                vatPercentage := 13.75; // Asegúrate de que "VAT %" sea el nombre correcto del campo
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

        addafter("Location Code")
        {
            field("Monto liquido"; Rec."Monto Liquido")
            {
                ApplicationArea = Basic, Suite;
                Visible = EsBoletaHonorarios;
                trigger OnValidate()
                var
                    directUnitCost: Decimal;
                    vatPercentage: Decimal;
                    boletaHonorario: Codeunit 50110;
                    PurchaseHeader: Record "Purchase Header";
                begin
                    directUnitCost := Rec."Monto Liquido"; // Obtener el nuevo valor de "Direct Unit Cost"               
                    vatPercentage := 13.75; // Asegúrate de que "VAT %" sea el nombre correcto del campo
                    boletaHonorario.CalculateRetention(
                    directUnitCost,
                    Rec."Retención",
                    Rec."Retención + base",
                    vatPercentage
                    );
                    Rec."Direct Unit Cost" := Rec."Retención + base";
                end;
            }

        }
        // Modificar el campo Quantity basado en EsBoletaHonorarios, quitar  el message

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                Message('El valor de EsBoletaHonorarios es: %1', EsBoletaHonorarios);
                if EsBoletaHonorarios then begin
                    Rec.Quantity := 1; // Modificar el valor de Quantity según sea necesario
                    Rec.Type := Rec.Type::"Allocation Account"; // Cambiar el tipo a "Cuenta de asignación"
                    Rec."No." := '1'; // Asignar el valor "1" al campo "No." pero esto debiese ser dinamico 
                    Rec."Description" := 'HONORARIOS';
                end
            end;
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
                Visible = true;
                // Puedes agregar más propiedades según sea necesario
            }
            field(REtencionplusbase; rec."Retención + base")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retención incl.';
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false;
                Visible = true;

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
                Caption = '% Impuesto retenido';
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false;
                Visible = true;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        if EsBoletaHonorarios then begin
            Rec.Quantity := 1; // Modificar el valor de Quantity según sea necesario
            Rec.Type := Rec.Type::"Allocation Account"; // Cambiar el tipo a "Cuenta de asignación"
            Rec."No." := '1'; // Asignar el valor "1" al campo "No." pero esto debiese ser dinamico 
            Rec."Description" := 'HONORARIOS';

        end;
    end;

    trigger OnOpenPage()
    begin
        // Mostrar un mensaje con el valor actual de EsBoletaHonorarios
        Message('El valor de EsBoletaHonorarios es: %1', EsBoletaHonorarios);
        /*
        // Modificar la primera línea si es necesario
        if EsBoletaHonorarios then begin
            Rec."Monto Liquido" := 1; // Modificar el valor de Monto Liquido según sea necesario
            Rec.Quantity := 1; // Modificar el valor de Quantity según sea necesario
            Rec.Type := Rec.Type::"Allocation Account"; // Cambiar el tipo a "Cuenta de asignación"
            Rec."No." := '1'; // Asignar el valor "1" al campo "No."
            Rec."Description" := 'HONORARIOS';
            
    end;
*/
    end;

    //metodo que toma el dte y lo asigna a variable local para trabajarlo
    procedure SetEsBoletaHonorarios(Value: Boolean)
    begin
        EsBoletaHonorarios := Value;
        if EsBoletaHonorarios then begin
            Rec.Quantity := 1; // Modificar el valor de Quantity según sea necesario
            Rec.Type := Rec.Type::"Allocation Account"; // Cambiar el tipo a "Cuenta de asignación"
            Rec."No." := '1'; // Asignar el valor "1" al campo "No."
            Rec."Description" := 'HONORARIOS';
        end;
    end;


    var
        EsBoletaHonorarios: Boolean;

}