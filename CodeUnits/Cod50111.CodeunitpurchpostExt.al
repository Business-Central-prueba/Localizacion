// CodeUnits/Cod50111.CodeunitpurchpostExt.al
codeunit 50322 CustomPurchPostHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]
    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        NewAccount: Code[20]; // Define la nueva cuenta a la que deseas apuntar
    begin
        // Lógica para determinar la nueva cuenta
        NewAccount := '999999'; // Cambia a la cuenta deseada

        // Asignar la nueva cuenta a la línea de compra
        if PurchaseLine.Type = PurchaseLine.Type::Item then begin
            PurchaseLine."No." := NewAccount; // Asegúrate de que este campo sea el correcto
        end;

        // Aquí puedes agregar cualquier lógica adicional que necesites
        PostCustomFieldsToAccount(PurchaseLine);
    end;

    procedure PostCustomFieldsToAccount(PurchLine: Record "Purchase Line")
    var
        GLPost: Codeunit "Gen. Jnl.-Post Line"; //Postear línea en G/L
        CustomLine: Record "Gen. Journal Line"; //Línea de inserción en G/L para entries custom (999999 y 100000)
        CustomAccount: Record "G/L Account"; //Instancia de cuenta 999999
        CustomBalanceAccount: Record "G/L Account"; //Instancia de cuenta 100000

    begin
        // Obtener la cuenta 999999

        if CustomAccount.Get('999999') then begin
            CustomBalanceAccount.Get('100000');
            //Mensaje de depuración
            Message('Se ha encontrado la cuenta 999999. Procediendo con la inserción. Cuenta: ' + Format(CustomAccount."No.")
            + ' Nombre: ' + CustomAccount.Name + 'Tipo de doc de purchase: ' + Format(PurchLine."Document Type"));

            //Inicializar la línea de inserción en G/L
            CustomLine.Init();
            CustomLine."Posting Date" := PurchLine."Order Date";
            //Cuenta de retenciones
            CustomLine."Account No." := CustomAccount."No."; //Este número es la cuenta obtenida en CustomAccount get
            CustomLine."Account Type" := CustomLine."Account Type"::"G/L Account";
            CustomLine."Document Type" := PurchLine."Document Type";
            CustomLine."Document No." := PurchLine."Document No.";

            //Cuenta de balance para consistencia de la cuenta
            CustomLine."Bal. Account No." := CustomBalanceAccount."No."; //Este número es la cuenta obtenida en CustomBalanceAccount get
            CustomLine."Bal. Account Type" := CustomLine."Account Type"::"G/L Account";
            CustomLine.Amount := PurchLine."Retención" + PurchLine."Retención + base"; // Usa tus campos personalizados
            //CustomLine.Amount := '0';

            GLPost.RunWithCheck(CustomLine);
        end else begin
            // Mostrar un popup si no se encuentra la cuenta
            Message('No se encontró la cuenta 999999. Verifica la configuración de cuentas.');
        end;

    end;
}