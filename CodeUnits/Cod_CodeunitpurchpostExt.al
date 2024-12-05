// CodeUnits/Cod50111.CodeunitpurchpostExt.al
codeunit 50322 CustomPurchPostHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]
    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        AllocationLine: Record "Allocation Line";
    begin
        //AllocationLine.Amount := PurchaseLine."Retención + base";
        /*Message('OnAfterPostPurchLine');
        Message('Monto base: ' + Format(AllocationLine.Amount));*/
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
        AllocationLine: Record "Allocation Line";
    begin
        /*AllocationLine.Amount := TempPurchaseLine."Retención + base";
        Message('OnBeforeModifyTempLine');
        Message('Monto base: ' + Format(TempPurchaseLine."Direct Unit Cost"));
        Message('Monto total: ' + Format(TempPurchaseLine."Retención + base"));
        Message('Monto total IVA: ' + Format(TempPurchaseLine."Amount Including VAT"));*/
    end;
}