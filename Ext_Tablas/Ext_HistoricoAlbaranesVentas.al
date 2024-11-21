tableextension 50130 "Ext. His. Alabaranes Venta" extends "Sales Shipment Header"
{
    fields
    {

        field(70004; Folio; Integer)
        {
            Caption = 'Folio';
            DataClassification = ToBeClassified;
        }

        field(70005; codigoActividad; Code[200])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
        }

        field(70006; Transportista; Code[50])
        {
            Caption = 'Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }

        field(70009; DV; Code[1])
        {
            Caption = 'Dígito verificador';
            DataClassification = ToBeClassified;
        }

        field(70010; rut_Transportista; Integer)
        {
            Caption = 'RUT Transportista';
            DataClassification = ToBeClassified;
        }

        field(70008; patenteTransportista; Text[6])
        {
            Caption = 'Patente Transportista';
            DataClassification = ToBeClassified;
        }

        field(70007; rutTransportista; Text[12])//--Obsoleto
        {
            Caption = 'RUT Transportista';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Problemas con el tipo de valor';
        }
    }
}