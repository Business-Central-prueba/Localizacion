codeunit 50109 XMLTstingTipoBanco
{
    procedure ImportarXMLDataTipoBanco()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        TipoBanco: Record tipoBanco;
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
            TipoBanco.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'codigoTipoBanco':
                        TipoBanco.Validate(TipoBanco.Codigo_Tipo_Banco, Node2.AsXmlElement().InnerText);
                    'nombreBanco':
                        TipoBanco.Validate(TipoBanco.nombreBanco, Node2.AsXmlElement().InnerText);
                    'descripcionTipoBanco':
                        TipoBanco.Validate(TipoBanco.descripcionTipoBanco, Node2.AsXmlElement().InnerText);
                end;
            end;
            TipoBanco.Insert(true);
        end;
    end;




    //--------------------------------------------------Exportar XML
    procedure XMLExportarTipoBanco()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        TipoBanco: Record tipoBanco;
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
        TipoBanco.FindSet();

        repeat

            ParentNode := XmlElement.Create('TipoBanco');
            RootNode.add(ParentNode);
            //FieldCaption := Cust.FieldCaption("No.");
            FieldCaption := 'codigoTipoBanco';
            //Message(FieldCaption);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(TipoBanco.Codigo_Tipo_Banco));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'nombreBanco';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(TipoBanco.nombreBanco);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'descripcionTipoBanco';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(TipoBanco.descripcionTipoBanco);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until TipoBanco.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_TipoBanco.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de tipo de bancos.');

    end;
}