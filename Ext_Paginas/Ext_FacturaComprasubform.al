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
        modify("Location code")
        {
            Visible = not EsBoletaHonorarios;
        }

        modify("Unit of Measure Code")
        {
            Visible = not EsBoletaHonorarios;
        }

        modify("Item Reference No.")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("Line Discount %")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = not EsBoletaHonorarios;
        }
        modify("Quantity")
        {
            Editable = not EsBoletaHonorarios;
        }

        addafter("Location Code")
        {
            field("Monto liquido"; Rec."Monto Liquido")
            {
                ApplicationArea = Basic, Suite;
                Visible = EsBoletaHonorarios;
                Caption = 'Monto líquido';
                ToolTip = 'Localización Chilena. Monto líquido para boleta de honorarios.';
                trigger OnValidate()
                var
                    montoLiquido: Decimal;
                    retencionPercentage: Decimal;
                    boletaHonorario: Codeunit 50110;
                    PurchaseHeader: Record "Purchase Header";
                    PurchHeader: Record "Purchase Header"; //para probar historicos 
                    Allocation: Record "Allocation Account";
                    AllocationDist: Record "Alloc. Account Distribution";

                    existeCtaBoleta: Boolean;
                    contadorCuentas: Integer;
                begin
                    //Message(PurchaseHeader.DTE);
                    existeCtaBoleta := false;
                    montoLiquido := Rec."Monto Liquido"; // Obtener el valor de "Monto líquido"
                    contadorCuentas := 0;
                    if (Rec.Type = Rec.Type::"Allocation Account") then begin
                        Allocation.Get(Rec."No.");

                        AllocationDist.SetRange(AllocationDist."Allocation Account No.", Allocation."No.");
                        contadorCuentas := AllocationDist.Count;
                        if AllocationDist.FindSet() then
                            repeat
                                //Message('El contador va en %1', contadorCuentas);
                                if (AllocationDist.esBoletaHonorario) then begin
                                    existeCtaBoleta := true;
                                    retencionPercentage := AllocationDist.Percent;
                                    break;
                                end;

                            until AllocationDist.Next() = 0;

                        if (not existeCtaBoleta) then begin
                            Message('Advertencia: No se ha asignado una cuenta de retenciones. Revise los detalles de la cuenta de asignación seleccionada.');
                        end;

                        if (contadorCuentas < 2) then begin
                            Message('Advertencia: En la cuenta de asignación seleccionada solo existen %1 cuentas. Se recomienda asignar una cuenta de monto líquido y otra de monto de retención.', contadorCuentas);
                        end;

                        boletaHonorario.CalculateRetention(
                            montoLiquido,
                            Rec."Retención",
                            Rec."Retención + base",
                            retencionPercentage
                        );
                        Rec.Validate("Retención %", retencionPercentage);
                        Rec.Validate("Direct Unit Cost", Rec."Retención + base"); // Asigna RetencionBase a Direct unit
                        Rec.Validate("Quantity", 1);
                        //seccion para revisar paso a historico 
                        if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                            PurchHeader.Get(Rec."Document Type", Rec."Document No.");
                            PurchHeader.Validate("Monto Liquido", Rec."Monto Liquido");
                            PurchHeader.Validate("Retención", Rec."Retención");
                            PurchHeader.Validate("Retención %", Rec."Retención %");
                            PurchHeader.Validate("Retención + base", Rec."Retención + base");
                            PurchHeader.Modify(true);
                        end;
                        //fin seccion
                        //DeltaUpdateTotals(); //Actualiza los totales
                    end else begin
                        Message('Para el correcto funcionamiento del registro de Boletas de honorarios, el tipo de línea de compra debe asignarse como "Cuenta de asignación".');
                    end;
                end;


            }


        }


        addafter(Control15)
        {
            group("Boleta Honorarios")
            {
                Visible = false;
                group("")
                {

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
        }

        modify(Control33) // Este es el grupo donde están los campos existentes
        {
            Visible = not EsBoletaHonorarios;
        }
        modify(Control15) // Este es el grupo donde están los campos existentes
        {
            Visible = not EsBoletaHonorarios;
        }
    }


    trigger OnAfterGetRecord()
    var
        AllocationAccountRec: Record "Allocation Account";
        ValidAccount: Record "Allocation Account";
        PurchInvoiceValidation: Codeunit "CustomPurchPostHandler";

    begin
        if EsBoletaHonorarios then begin
            Rec.Validate(Type, Rec.Type::"Allocation Account");
            // Obtener la cuenta válida utilizando el procedimiento
            ValidAccount := PurchInvoiceValidation.ObtenerCtaAsignacionBoleta();

            if ValidAccount.IsEmpty() then begin
                Message('No se encontró ninguna cuenta de asignación válida con "esBoletaHonorario" marcado.');
                //exit; // Salir si no hay cuentas válidas
            end;
            if not ValidAccount.IsEmpty() then begin
                Rec.Validate("No.", ValidAccount."No.");
            end;
        end;
    end;


    //metodo que toma el DTE y lo asigna a variable local para trabajarlo
    procedure SetEsBoletaHonorarios(Value: Boolean; Picked: Boolean)
    begin
        EsBoletaHonorarios := Value;
        /*
        if not EsBoletaHonorarios then begin
            Rec.Validate(Rec."Monto Liquido", 0);
            Rec.Validate(Rec."Direct Unit Cost", 0);
            Rec.Validate(Rec."Retención + base", 0);
            Rec.Validate(Rec."Retención", 0);
            //Message(Format(Rec."Monto Liquido"));
            //Message(Format(Rec."Direct Unit Cost"));
            //Message(Format(Rec."Retención + base"));
            if Picked then begin
                setBoletaLineType(EsBoletaHonorarios);
            end;
            CurrPage.Update(true);
        end;
        */
    end;

    var
        EsBoletaHonorarios: Boolean;

}