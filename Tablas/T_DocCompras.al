table 50164 DocumentoCompras
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = PageDocCompras;

    fields
    {
        field(1; codigoDocCompra; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Código compra';
        }

        field(2; nombreDocumentoCompra; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nombre documento compra';
        }
    }

    keys
    {
        key(Key1; codigoDocCompra)
        {
            Clustered = true;
        }
    }

}