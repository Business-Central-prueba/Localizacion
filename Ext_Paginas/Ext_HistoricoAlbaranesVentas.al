
//Verificar bien si el ID no está utilizado por otra entidad

pageextension 50130 "Page Ext. Hist. Alb. Venta" extends "Posted Sales Shipment"
{
    layout
    {
        addfirst(General)
        {


            field(Folio; Rec.Folio)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. N° de folio';
                Caption = 'N° Folio';
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
                        Rec.codigoActividad := ItemRec.codigoActividad;
                end;
            }
        }

        addlast(General)
        {
            field(Transportista; Rec.Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Transportista';
                Caption = 'Transportista';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record "Shipping Agent";
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Shipping Agents", ItemRec) = Action::LookupOK then
                        Rec.Transportista := ItemRec."Code";
                end;
            }

            field(rutTransportista; Rec.rut_Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. RUT de Transportista';
                Caption = 'RUT Transportista';
            }
            field(DV; Rec.DV)
            {
                ApplicationArea = All;
                Caption = 'Dígito verificador';
                ToolTip = 'Localización Chilena. Dígito verificador de RUT transportista.';
            }

            field(patenteTransportista; Rec.patenteTransportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Patente de Transportista';
                Caption = 'Patente transportista';
            }
        }
    }

    actions
    {

    }

}