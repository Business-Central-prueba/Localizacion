
table 50167 tipoTransaccion
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Tipo de Transacciones";
    fields
    {

        field(3; Id_Transaccion; Code[30])
        {
            Caption = 'Id de transacción';
            DataClassification = ToBeClassified;
        }
        field(2; descripcionTransaccion; Text[256])
        {
            Caption = 'Descripcion Transaccion';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Id_Transaccion)
        {
            Clustered = true;
        }
    }

}