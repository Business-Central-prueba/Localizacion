table 50101 PDF
{
    Caption = 'PDF';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}