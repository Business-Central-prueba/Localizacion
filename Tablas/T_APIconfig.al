table 50129 "API Configuration"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Postman-Token"; Text[250])
        {

            DataClassification = ToBeClassified;

        }
        field(3; "Content-Type"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Content-Length"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Host"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User-Agent"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Accept"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Accept-Encoding"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Connection"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "apikey"; Text[250])
        {

            DataClassification = ToBeClassified;
        }
        field(11; "Idempotency-Key"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Response Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Response JSON"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Emission Status"; Text[50])
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
