pageextension 50126 "Page Ext. Porveedor" extends "Vendor Card"
{
    layout
    {
        addfirst(General)
        {

            field(rutProveedor; Rec.RUT)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. RUT de proveedor';
                Caption = 'RUT';
            }

            field(DV; Rec.DV)
            {
                ToolTip = 'Localización Chilena. Dígito verificador';
                Caption = 'Dígito verificador';
                ApplicationArea = All;
            }

            field(codigoActividad; Rec.codigoActividad)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Actividad económica';
                Caption = 'Actividad económica';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record actividadEconomica;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Actividades Económicas", ItemRec) = Action::LookupOK then
                        Rec.codigoActividad := ItemRec.nombre_Actividad;
                end;
            }
        }

        addlast("Address & Contact")
        {
            field(FacebookProveedor; Rec.FacebookProveedor)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Cuenta de Facebook del proveedor';
                Caption = 'Facebook';
            }

            field(Instagram; Rec.Instagram)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Cuenta de Instagram del proveedor';
                Caption = 'Instagram';
            }

            field(LinkedIn; Rec.LinkedIn)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Cuenta de LinkedIn del proveedor';
                Caption = 'LinkedIn';
            }
        }
    }

    actions
    {

    }

}