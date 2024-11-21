
//Verificar bien si el ID no está utilizado por otra entidad

pageextension 50125 "Page Ext. Cliente" extends "Customer Card"
{
    layout
    {
        addfirst(General)
        {
            field(Rut_Cliente; Rec.Rut_Cliente)
            {
                ApplicationArea = All;
                Caption = 'RUT';
                ToolTip = 'Localización Chilena. RUT del cliente';
            }

            field(DV; Rec.DV)
            {
                Caption = 'Dígito verificador';
                ToolTip = 'Localización Chilena. Dígito verificador de RUT';
                ApplicationArea = All;

            }

            field(codigo_Actividad; Rec.codigo_Actividad)
            {
                ApplicationArea = All;
                Caption = 'Actividad económica';
                ToolTip = 'Localización Chilena. Actividad económica.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record actividadEconomica;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Actividades Económicas", ItemRec) = Action::LookupOK then
                        Rec.codigo_Actividad := ItemRec.nombre_Actividad;
                end;
            }

        }
        addlast("Address & Contact")
        {
            field(FacebookCliente; Rec.FacebookCliente)
            {
                ApplicationArea = All;
                Caption = 'Facebook';
                ToolTip = 'Localización Chilena. Cuenta de Facebook de cliente';
            }

            field(Instagram; Rec.Instagram)
            {
                ApplicationArea = All;
                Caption = 'Instagram';
                ToolTip = 'Localización Chilena. Cuenta de Instagram de cliente';
            }

            field(LinkedIn; Rec.LinkedIn)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Cuenta de LinkedIn de cliente';
                Caption = 'LinkedIn';
            }
            field(RewardPoints; Rec.RewardPoints)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena.';
                Caption = 'Rewards ';
            }

        }

    }

}