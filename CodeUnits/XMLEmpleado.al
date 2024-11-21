codeunit 50118 XMLTstingEmpleado
{
    procedure ImportarXMLDataEmpleado()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        Empleado: Record Employee;
        Element: XmlElement;
    begin
        if UploadIntoStream('Upload XML File', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            Empleado.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'No.':
                        Empleado.Validate(Empleado."No.", Node2.AsXmlElement().InnerText);
                    /*'Name':
                        Empleado.Validate(Empleado.Name, Node2.AsXmlElement().InnerText);
                    'Firstfamilyname':
                        Empleado.Validate(Empleado."First Family Name", Node2.AsXmlElement().InnerText);
                    'Secondfamiliname':
                        Empleado.Validate(Empleado."Second Family Name", Node2.AsXmlElement().InnerText);*/
                    'Initials':
                        Empleado.Validate(Empleado.Initials, Node2.AsXmlElement().InnerText);
                    'jobtitle':
                        Empleado.Validate(Empleado."Job Title", Node2.AsXmlElement().InnerText);
                    'searchname':
                        Empleado.Validate(Empleado."Search Name", Node2.AsXmlElement().InnerText);
                    'phoneno':
                        Empleado.Validate(Empleado."Phone No.", Node2.AsXmlElement().InnerText);
                    'emailcom':
                        Empleado.Validate(Empleado."Company E-Mail", Node2.AsXmlElement().InnerText);
                    'RUT':
                        Evaluate(Empleado.RUT, Node2.AsXmlElement().InnerText, 9);
                    'DV':
                        Empleado.Validate(Empleado.DV, Node2.AsXmlElement().InnerText);
                    'Address':
                        Empleado.Validate(Empleado.Address, Node2.AsXmlElement().InnerText);
                    'Address2':
                        Empleado.Validate(Empleado."Address 2", Node2.AsXmlElement().InnerText);
                    'city':
                        Empleado.Validate(Empleado.City, Node2.AsXmlElement().InnerText);
                    'PostCODE':
                        Empleado.Validate(Empleado."Post Code", Node2.AsXmlElement().InnerText);
                    'CountyRegionCode':
                        Empleado.Validate(Empleado."Country/Region Code", Node2.AsXmlElement().InnerText);
                    'mobilephoneno':
                        Empleado.Validate(Empleado."Mobile Phone No.", Node2.AsXmlElement().InnerText);
                    'pager':
                        Empleado.Validate(Empleado.Pager, Node2.AsXmlElement().InnerText);
                    'extension':
                        Empleado.Validate(Empleado.Extension, Node2.AsXmlElement().InnerText);
                    'email':
                        Empleado.Validate(Empleado."E-Mail", Node2.AsXmlElement().InnerText);
                    'altaddresscode':
                        Empleado.Validate(Empleado."Alt. Address Code", Node2.AsXmlElement().InnerText);
                    'causeofinativitycode':
                        Empleado.Validate(Empleado."Cause of Inactivity Code", Node2.AsXmlElement().InnerText);
                    'groundsforterms':
                        Empleado.Validate(Empleado."Grounds for Term. Code", Node2.AsXmlElement().InnerText);
                    'emplymtcontractcode':
                        Empleado.Validate(Empleado."Emplymt. Contract Code", Node2.AsXmlElement().InnerText);
                    'statsgroupcode':
                        Empleado.Validate(Empleado."Statistics Group Code", Node2.AsXmlElement().InnerText);
                    'resourceno':
                        Empleado.Validate(Empleado."Resource No.", Node2.AsXmlElement().InnerText);
                    'salesperspurchcode':
                        Empleado.Validate(Empleado."Salespers./Purch. Code", Node2.AsXmlElement().InnerText);
                    'socialsecurity':
                        Empleado.Validate(Empleado."Social Security No.", Node2.AsXmlElement().InnerText);
                    'unioncode':
                        Empleado.Validate(Empleado."Union Code", Node2.AsXmlElement().InnerText);
                    'unionmembership':
                        Empleado.Validate(Empleado."Union Membership No.", Node2.AsXmlElement().InnerText);
                    'employeepostinggroup':
                        Empleado.Validate(Empleado."Employee Posting Group", Node2.AsXmlElement().InnerText);
                    'applicationmethod':
                        Evaluate(Empleado."Application Method", Node2.AsXmlElement().InnerText, 9);
                    'bankbranchno':
                        Empleado.Validate(Empleado."Bank Branch No.", Node2.AsXmlElement().InnerText);
                    'bankaccount':
                        Empleado.Validate(Empleado."Bank Account No.", Node2.AsXmlElement().InnerText);
                    'iban':
                        Empleado.Validate(Empleado.IBAN, Node2.AsXmlElement().InnerText);
                    'swiftcode':
                        Empleado.Validate(Empleado."SWIFT Code", Node2.AsXmlElement().InnerText);
                end;
            end;
            Empleado.Insert(true);
        end;
    end;


    //-----------------------------------------Exportar el XML
    procedure XMLExportarEmpleado()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        Employee: Record Employee;
        ParentNode: XmlElement;
        FieldCaption: Text;
        XMLTxt: XmlText;
        ChildNode: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        ReadTxt: Text;
        WriteTxt: Text;
    begin
        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XMLDec);
        RootNode := XmlElement.Create('Table');
        XMLDoc.Add(RootNode);
        Employee.FindSet();

        repeat

            ParentNode := XmlElement.Create('Vendor');
            RootNode.add(ParentNode);

            FieldCaption := 'No.';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."No.");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*
            
            FieldCaption := 'Name';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee.Name);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Firstfamilyname';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."First Family Name");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Secondfamiliname';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."Second Family Name");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            */

            FieldCaption := 'Initials';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee.Initials);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'jobtitle';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."Job Title");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'searchname';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."Search Name");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'phoneno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."Phone No.");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'emailcom';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Employee."Company E-Mail");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'RUT';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.RUT));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'DV';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.DV));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //--------------------------------------Seccion address y contact

            FieldCaption := 'Address';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.Address));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Address2';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Address 2"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'city';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.City));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'PostCODE';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Post Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'CountyRegionCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Country/Region Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'RUT';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.RUT));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'mobilephoneno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Mobile Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'pager';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.Pager));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'extension';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.Extension));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'phoneno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'email';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."E-Mail"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'altaddresscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Alt. Address Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //------------------------------Seccion Administration
            FieldCaption := 'causeofinativitycode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Cause of Inactivity Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'groundsforterms';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Grounds for Term. Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'emplymtcontractcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Emplymt. Contract Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'statsgroupcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Statistics Group Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'resourceno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Resource No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'salesperspurchcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Salespers./Purch. Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //----------------------------------seccion personal
            FieldCaption := 'socialsecurity';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Social Security No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'unioncode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Union Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'unionmembership';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Union Membership No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //--------------------------------seccion payments

            FieldCaption := 'employeepostinggroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Employee Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'applicationmethod';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Application Method"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'bankbranchno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Bank Branch No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'bankaccount';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."Bank Account No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'iban';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee.IBAN));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'swiftcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Employee."SWIFT Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


        until Employee.Next() = 0;
        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_Vendor.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de proveedor.');

    end;

}