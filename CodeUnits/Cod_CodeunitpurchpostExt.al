// CodeUnits/Cod50111.CodeunitpurchpostExt.al
codeunit 50322 CustomPurchPostHandler
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforeFillTempLines', '', false, false)]
    local procedure OnRunOnBeforeFillTempLinesHandler(PreviewMode: Boolean; GenJnlLineDocNo: Code[20])
    begin
        if not PreviewMode then
            exit;

        AddCustomFieldsToTempLines();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostLines', '', false, false)]
    local procedure OnBeforePostLinesHandler(var TempPurchLineGlobal: Record "Purchase Line" temporary; PurchHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        if not PreviewMode then
            exit;

        AddCustomFieldsToTempLines();
    end;

    local procedure AddCustomFieldsToTempLines()
    var
        TempPurchLine: Record "Purchase Line" temporary;
        PurchLine: Record "Purchase Line";
    begin
        if TempPurchLine.IsEmpty() then
            exit;

        // Recorremos las líneas temporales y agregamos los campos personalizados.
        if TempPurchLine.FindSet() then
            repeat
                // Suponiendo que los campos extendidos están en la tabla Purchase Line.
                PurchLine.Get(TempPurchLine."Document Type", TempPurchLine."Document No.", TempPurchLine."Line No.");
                TempPurchLine."Your Custom Field 1" := PurchLine."Your Custom Field 1";
                TempPurchLine."Your Custom Field 2" := PurchLine."Your Custom Field 2";
                TempPurchLine.Modify();
            until TempPurchLine.Next() = 0;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]

    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        GLPost: Codeunit "Gen. Jnl.-Post Line"; //Postear línea en G/L
        CustomLine: Record "Gen. Journal Line"; //Línea de inserción en G/L para entries custom (999999 y 100000)
        TotalAccount: Record "G/L Account"; //Instancia de cuenta 999999
        RetentionAccount: Record "G/L Account"; //Instancia de cuenta 100000
        BaseAmountAccount: Record "G/L Account"; //Instancia de cuenta 100001

    begin
        // Obtener la cuenta 999999

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

            //Cuenta de retenciones 999999
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

            //Cuenta de balance para consistencia de la cuenta
            //CustomLine."Bal. Account No." := CustomBalanceAccount."No."; //Este número es la cuenta obtenida en CustomBalanceAccount get
            //CustomLine."Bal. Account Type" := CustomLine."Account Type"::"G/L Account";
            //CustomLine.Amount := PurchLine."Retención" + PurchLine."Retención + base"; // Usa tus campos personalizados
            //CustomLine.Amount := '0';

        end else begin
            // Mostrar un popup si no se encuentra la cuenta
            Message('No se encontró la cuenta . Verifica la configuración de cuentas.');
        end;

    end;
}