codeunit 50106 XMLTstingCodigoPostal
{
    procedure ImportarXMLDataCodigoPostal()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        CodigoPostal: Record "Post Code";
        Element: XmlElement;
        b: Integer;
    begin
        if UploadIntoStream('Subir contenido XML', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            CodigoPostal.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'Code':
                        CodigoPostal.Validate(CodigoPostal.Code, Node2.AsXmlElement().InnerText);
                    'CountryCode':
                        CodigoPostal.Validate(CodigoPostal."Country/Region Code", Node2.AsXmlElement().InnerText);
                    'County':
                        CodigoPostal.Validate(CodigoPostal.County, Node2.AsXmlElement().InnerText);
                    'City':
                        CodigoPostal.Validate(CodigoPostal.City, Node2.AsXmlElement().InnerText);
                end;
            end;
            CodigoPostal.Insert(true);
        end;
    end;

    //--------------------------------------------Exportar XML
    procedure XMLExportarCodPostal()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        CodigoPostal: Record "Post Code";
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
        CodigoPostal.FindSet();

        repeat

            ParentNode := XmlElement.Create('CodigoPostal');
            RootNode.add(ParentNode);
            FieldCaption := 'Code';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(CodigoPostal.Code);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            //FieldCaption := CodigoPostal.FieldCaption("Country/Region Code");
            FieldCaption := 'CountryCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(CodigoPostal."Country/Region Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //FieldCaption := CodigoPostal.FieldCaption("County Code");
            FieldCaption := 'County';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(CodigoPostal.County);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := CodigoPostal.FieldCaption(City);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(CodigoPostal.City);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until CodigoPostal.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_CodigoPostal.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Código postal.');

    end;
}