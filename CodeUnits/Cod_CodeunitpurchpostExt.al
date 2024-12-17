// CodeUnits/Cod50111.CodeunitpurchpostExt.al
codeunit 50322 CustomPurchPostHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostInvoice', '', false, false)]
    local procedure OnBeforePostInvoice(var PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; var Window: Dialog; HideProgressWindow: Boolean; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var InvoicePostingInterface: Interface "Invoice Posting"; var InvoicePostingParameters: Record "Invoice Posting Parameters"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10])

    begin
        Message('Retencion y base: ' + Format(TotalPurchLine."Retención + base"));
        //Message('Retencion y base header: ' + Format(PurchHeader."Retención + base"));
        /*PurchHeader."Monto Liquido" := TotalPurchLine."Monto Liquido";
        PurchHeader."Retención" := TotalPurchLine."Retención";
        PurchHeader."Retención %" := TotalPurchLine."Retención %";
        PurchHeader."Retención + base" := TotalPurchLine."Retención + base";*/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Allocation Account Mgt.", 'OnGenerateFixedAllocationLinesOnAfterInsertAllocationLine', '', false, false)]
    local procedure OnGenerateFixedAllocationLinesOnAfterInsertAllocationLine(var AllocationLine: Record "Allocation Line"; var AllocAccountDistibution: Record "Alloc. Account Distribution")
    var
    // PurchaseLine: Record "Purchase Line";

    begin
        // Message('P Line N°: ' + Format(PurchaseLine."No."));
        // Message('P Line Retencion: ' + Format(PurchaseLine."Retención + base"));
        // Message('ALL ACC Amount: ' + Format(AllocationLine.Amount));
    end;
    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]

    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        GLPost: Codeunit "Gen. Jnl.-Post Line"; //Postear línea en G/L
        CustomLine: Record "Gen. Journal Line"; //Línea de inserción en G/L para entries custom 
        TotalAccount: Record "G/L Account"; //Instancia de cuenta Total Retenciones
        RetentionAccount: Record "G/L Account"; //Instancia de cuenta Retenciones
        BaseAmountAccount: Record "G/L Account"; //Instancia de cuenta Monto Base de la factura

    begin
        if PurchaseHeader."DTE" = 'Boleta de honorarios' then begin
            if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice then begin
                if TotalAccount.Get('1753') then begin
                    RetentionAccount.Get('1754');
                    BaseAmountAccount.Get('1755');
                    //Mensaje de depuración

                    Message('Se ha encontrado la cuenta. Procediendo con la inserción. Cuenta: ' + Format(TotalAccount."No.")
                + ' Nombre: ' + TotalAccount.Name + 'Tipo de doc de purchase: ' + Format(PurchaseLine."Document Type"));
                    //Inicializar la línea de inserción en G/L
                    CustomLine.Init();
                    CustomLine."Posting Date" := PurchaseLine."Order Date";
                    //Cuenta de retenciones 1753
                    CustomLine."Account No." := TotalAccount."No."; //Este número es la cuenta obtenida en TotalAccount.get
                    CustomLine."Account Type" := CustomLine."Account Type"::"G/L Account";
                    CustomLine."Document Type" := PurchaseLine."Document Type";
                    CustomLine."Document No." := PurchaseLine."Document No.";
                    CustomLine.Amount := PurchaseLine."Retención + base" * (-1);
                    GLPost.RunWithCheck(CustomLine);


                    CustomLine.Init();
                    CustomLine."Posting Date" := PurchaseLine."Order Date";
                    CustomLine."Account No." := RetentionAccount."No."; //Este número es la cuenta obtenida en RetentionAccount get
                    CustomLine."Account Type" := CustomLine."Account Type"::"G/L Account";
                    CustomLine."Document Type" := PurchaseLine."Document Type";
                    CustomLine."Document No." := PurchaseLine."Document No.";
                    CustomLine.Amount := PurchaseLine."Retención";
                    GLPost.RunWithCheck(CustomLine);

                    CustomLine.Init();
                    CustomLine."Posting Date" := PurchaseLine."Order Date";
                    CustomLine."Account No." := BaseAmountAccount."No."; //Este número es la cuenta obtenida en BaseAmountAccount get
                    CustomLine."Account Type" := CustomLine."Account Type"::"G/L Account";
                    CustomLine."Document Type" := PurchaseLine."Document Type";
                    CustomLine."Document No." := PurchaseLine."Document No.";
                    CustomLine.Amount := PurchaseLine."Direct Unit Cost";
                    GLPost.RunWithCheck(CustomLine);

                end else begin
                    // Mostrar un popup si no se encuentra la cuenta
                    Message('No se encontró la cuenta . Verifica la configuración de cuentas.');
                end;
            end;
        end;
    end;
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeModifyTempLine', '', false, false)]
    local procedure OnBeforeModifyTempLine(var TempPurchaseLine: Record "Purchase Line" temporary)
    var
    // AllocationLine: Record "Allocation Line";
    begin
        /*AllocationLine.Amount := TempPurchaseLine."Retención + base";
        Message('OnBeforeModifyTempLine');
        Message('Monto base: ' + Format(TempPurchaseLine."Direct Unit Cost"));
        Message('Monto total: ' + Format(TempPurchaseLine."Retención + base"));
        Message('Monto total IVA: ' + Format(TempPurchaseLine."Amount Including VAT"));*/

    end;

    procedure ValidatePurchaseLines(PurchHeader: Record "Purchase Header"; IsHonorariumReceipt: Boolean)
    var
        PurchLine: Record "Purchase Line";
        AllocationAccountRec: Record "Allocation Account";
        AllocAccount: Record "Alloc. Account Distribution";
        HasValidAllocation: Boolean;
    begin
        if not IsHonorariumReceipt then
            exit; // No es Boleta de Honorarios, no validar

        // Validar que solo haya una línea en caso de Boleta de Honorarios

        // Filtrar líneas del documento
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");

        if PurchLine.Count() > 1 then begin
            Message('lineas:  %1 ', PurchLine.Count());
            Error('Para tipo de DTE: Boleta de Honorarios, solo agregue una linea. ');
        end;

        if PurchLine.FindSet() then begin
            repeat
                if PurchLine.Type = PurchLine.Type::"Allocation Account" then begin
                    AllocationAccountRec.SetRange("No.", PurchLine."No.");

                    // Validar si el nombre contiene "NOMBRE CUENTA"
                    if AllocationAccountRec.FindSet() then begin
                        repeat
                            if ((AllocationAccountRec.Name) = 'Cta. Prueba') then begin
                                // Buscar cuentas en Alloc. Account Distribution asociadas
                                AllocAccount.SetRange("Allocation Account No.", AllocationAccountRec."No.");
                                AllocAccount.SetRange(esBoletaHonorario, true);

                                if AllocAccount.FindFirst() then begin
                                    HasValidAllocation := true;
                                    Break;
                                end;
                            end;
                        until AllocationAccountRec.Next() = 0;

                        if HasValidAllocation then
                            Break;
                    end;
                end;
            until PurchLine.Next() = 0;

            // Si no hay asignación válida, mostrar error
            if not HasValidAllocation then
                Error('Debe configurar al menos una cuenta asignada con "Cta. Retención" para este documento.');
        end else
            Error('El documento no tiene líneas.'); // Mensaje adicional si no hay líneas
    end;


}