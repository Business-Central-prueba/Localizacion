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
    end;
}