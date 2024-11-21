tableextension 50107 "Ext. Proveedor Actividad" extends Vendor
{
    fields
    {
        field(50103; codigoActividad; Code[200])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
        }

        field(50105; Instagram; Text[100])
        {
            Caption = 'Instagram';
            DataClassification = ToBeClassified;
        }

        field(50106; LinkedIn; Text[100])
        {
            Caption = 'LinkedIn';
            DataClassification = ToBeClassified;
        }

        field(50107; FacebookProveedor; Text[100])
        {
            Caption = 'Facebook';
            DataClassification = ToBeClassified;
        }

        field(50108; RUT; Integer)
        {
            Caption = 'RUT';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(RUT);
            end;
        }

        field(50109; DV; Code[1])
        {
            Caption = 'Dígito verificador';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ValidarRut: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRut.ValidarDigitoVerificador(Rec.RUT, DV);
            end;
        }
    }
}