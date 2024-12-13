pageextension 50666 Ext_FacturaCompra_subform extends "Purch. Invoice Subform"
{

    // Agregar un nuevo campo en el grupo existente
    layout
    {
        modify("Direct Unit Cost")
        {
            Editable = not EsBoletaHonorarios;
            /*trigger OnAfterValidate()
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
            end;*/
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
                    montoLiquido: Decimal;
                    retencionPercentage: Decimal;
                    boletaHonorario: Codeunit 50110;
                    PurchaseHeader: Record "Purchase Header";
                    Allocation: Record "Allocation Account";
                    AllocationDist: Record "Alloc. Account Distribution";
                    AllocationLine: Record "Allocation Line";
                    GLAccount: Record "G/L Account";
                begin
                    //Message(PurchaseHeader.DTE);
                    montoLiquido := Rec."Monto Liquido"; // Obtener el valor de "Monto líquido"               
                    if (Rec.Type = Rec.Type::"Allocation Account") then begin
                        Allocation.Get(Rec."No.");

                        AllocationDist.SetRange(AllocationDist."Allocation Account No.", Allocation."No.");

                        //Message('ALL ACC Number: ' + Format(Allocation."No.") + 'Nombre: ' + Format(Allocation.Name));
                        if AllocationDist.FindSet() then
                            repeat
                                GLAccount.Get(AllocationDist."Destination Account Number");
                                //Message('ALL DIST Number: ' + Format(AllocationDist."Allocation Account No.") + 'Destination: ' + Format(AllocationDist."Destination Account Number") +
                                //'Percentage' + Format(AllocationDist.Percent) + 'Name: ' + Format(GLAccount.Name));

                                if (UpperCase(GLAccount.Name).Contains('RETENCIÓN') or UpperCase(GLAccount.Name).Contains('RETENCION')) then begin
                                    retencionPercentage := AllocationDist.Percent;
                                end;
                            until AllocationDist.Next() = 0;

                        boletaHonorario.CalculateRetention(
                            montoLiquido,
                            Rec."Retención",
                            Rec."Retención + base",
                            retencionPercentage
                        );
                        Rec.Validate("Direct Unit Cost", Rec."Retención + base"); // Asigna RetencionBase a Direct unit
                        Rec.Validate("Quantity", 1);

                        DeltaUpdateTotals(); //Actualiza los totales
                    end;
                end;
            }

        }
        //esto solo se dispara al modificar el quantity
        /*
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
        */


        addlast(Control15) // Este es el grupo donde están los campos existentes
        {
            field(REtencion; rec."Retención")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retención'; // Cambia el nombre del campo según sea necesario
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false; // Permitir edición
                Visible = true;
            }
            field(REtencionplusbase; rec."Retención + base")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retención incl.';
                ToolTip = 'This is a new field added to the Purch. Invoice Subform.';
                Editable = false;
                Visible = true;
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
    var
        AllocationAccountRec: Record "Allocation Account";
    begin
        if EsBoletaHonorarios then begin

            Rec.Validate(Type, Rec.Type::"Allocation Account");
            // Buscar la cuenta de asignación que contiene el string "PRUEBA"
            if AllocationAccountRec.FindFirst() then begin
                if AllocationAccountRec.Name.Contains('Prueba') then begin
                    Rec.Validate("No.", AllocationAccountRec."No.");
                end else begin
                    Error('No se encontró una cuenta de asignación que contenga "Prueba".');
                end;
            end else begin
                Error('No se encontraron cuentas de asignación.');
            end;
            //Rec.Validate("Quantity", 1); 
            //Rec.Quantity := 1;
        end;
    end;

    //metodo que toma el DTE y lo asigna a variable local para trabajarlo
    procedure SetEsBoletaHonorarios(Value: Boolean)
    begin
        EsBoletaHonorarios := Value;
        if not EsBoletaHonorarios then begin
            //Message('Que xd');
            Rec.Validate(Rec."Monto Liquido", 0);
            Rec.Validate(Rec."Direct Unit Cost", 0);
            Rec.Validate(Rec."Retención + base", 0);
            Rec.Validate(Rec."Retención", 0);
            //Message(Format(Rec."Monto Liquido"));
            //Message(Format(Rec."Direct Unit Cost"));
            //Message(Format(Rec."Retención + base"));
            CurrPage.Update(true);
        end;
    end;


    var
        EsBoletaHonorarios: Boolean;

}