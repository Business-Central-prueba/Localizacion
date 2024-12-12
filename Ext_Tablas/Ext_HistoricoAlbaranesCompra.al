tableextension 50132 "Ext. His. Alabaranes Compra" extends "Purch. Rcpt. Header"
{
    fields
    {

        field(50770; Folio; Integer)
        {
            Caption = 'Folio';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50778; codigoActividad; Code[200])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
            Editable = false;
        }

        field(50781; Transportista; Code[60])
        {
            Caption = 'Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }


        field(50782; DV; Code[1])
        {
            Caption = 'Dígito verificador';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50783; rut_Transportista; Integer)
        {
            Caption = 'RUT Transportista';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50780; patenteTransportista; Text[6])
        {
            Caption = 'Patente Transportista';
            DataClassification = ToBeClassified;
            Editable = false;
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