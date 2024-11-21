
// Verificar bien si el ID no está utilizado por otra entidad

tableextension 50129 "Rut Empleado" extends Employee
{
    fields
    {
        field(50703; RUT; Integer)
        {
            Caption = 'Localización Chile. RUT del empleado';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(RUT);
            end;
        }

        field(50699; DV; Code[1])
        {
            Caption = 'Localización Chile. Dígito verificador';
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