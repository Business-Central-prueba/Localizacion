codeunit 50103 XMLTstingBanco
{
    procedure ImportarXMLDataBanco()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        Bancos: Record Bancos;
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
            Bancos.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'codigoBanco':
                        Bancos.Validate(Bancos.codigoBanco, Node2.AsXmlElement().InnerText);
                    'nombreBanco':
                        Bancos.Validate(Bancos.nombreBanco, Node2.AsXmlElement().InnerText);
                    'opcionTipoBancos':
                        Bancos.Validate(Bancos.Opcion_Tipo_Banco, Node2.AsXmlElement().InnerText);
                end;
            end;
            Bancos.Insert(true);
        end;
    end;

//------------------------------------------Proceso para exportar XML
    procedure XMLExportarBanco()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        Banco: Record Bancos;
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
        Banco.FindSet();

        repeat

            ParentNode := XmlElement.Create('Banco');
            RootNode.add(ParentNode);
            //FieldCaption := Cust.FieldCaption("No.");
            FieldCaption := 'codigoBanco';
            //Message(FieldCaption);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Banco.codigoBanco));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'nombreBanco';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Banco.nombreBanco);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'opcionTipoBancos';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(Banco.Opcion_Tipo_Banco));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);



        until Banco.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_Banco.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Bancos');

    end;

}