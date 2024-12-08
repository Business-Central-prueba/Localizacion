// CodeUnits/CodSalePost_EXT.al
codeunit 50323 CustomSalePostHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertInvoiceHeaderOnBeforeSalesInvHeaderTransferFields', '', false, false)]

    local procedure OnInsertInvoiceHeaderOnBeforeSalesInvHeaderTransferFields(var SalesHeader: Record "Sales Header")
    begin
        //Metodo necesario en campo Blob PDF para envio a Factura historica.
        SalesHeader.CalcFields("Blob PDF");
    end;
}