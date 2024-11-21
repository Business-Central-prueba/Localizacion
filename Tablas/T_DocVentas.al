table 50163 DocumentoVentas
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = PageDocVentas;

    fields
    {
        field(1; codigoDocVenta; Integer)
        {
            Caption = 'Código Venta';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }

        field(2; nombreDocumentoVenta; Text[100])
        {
            Caption = 'Nombre Documento Venta';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; codigoDocVenta)
        {
            Clustered = true;
        }
    }



}