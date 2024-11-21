codeunit 50322 CustomPurchPostHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchLine', '', false, false)]
    local procedure OnBeforePostPurchLine(var PurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        // Cargar el encabezado de compra correspondiente
        if PurchaseHeader.Get(PurchLine."Document Type", PurchLine."Document No.") then begin
            // Calcular el Total IVA incl. (CLP) como la suma de Retención y Base
            PurchaseHeader."amount" := PurchLine."Retención" + PurchLine."Retención + base"; // Asegúrate de que estos sean los campos correctos

            // Actualizar el encabezado de compra
            PurchaseHeader.Modify();
        end;
    end;
}