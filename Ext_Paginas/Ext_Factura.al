pageextension 50200 "Page Ext. Factura" extends "Sales Order"
{
    layout
    {
        addfirst(factboxes)
        {
            part(ItemDetailFactbox; "P_FactboxFactura")
            {
                visible = true;
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "document type" = field("Document Type"),
                              "document no." = field("document no."),
                              "Line No." = field("Line No.");

            }
        }
    }
    actions { }
}

