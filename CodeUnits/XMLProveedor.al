codeunit 50107 XMLTstingProveedor
{
    procedure ImportarXMLDataProveedor()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        Proveedor: Record Vendor;
        Element: XmlElement;
    begin
        if UploadIntoStream('Upload XML File', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            Proveedor.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'No.':
                        Proveedor.Validate(Proveedor."No.", Node2.AsXmlElement().InnerText);
                    'Name':
                        Proveedor.Validate(Proveedor.Name, Node2.AsXmlElement().InnerText);
                    'Facebook':
                        Proveedor.Validate(Proveedor.FacebookProveedor, Node2.AsXmlElement().InnerText);
                    'Instagram':
                        Proveedor.Validate(Proveedor.Instagram, Node2.AsXmlElement().InnerText);
                    'LinkedIn':
                        Proveedor.Validate(Proveedor.LinkedIn, Node2.AsXmlElement().InnerText);
                    'RUT':
                        Evaluate(Proveedor.RUT, Node2.AsXmlElement().InnerText, 9);
                    'DV':
                        Proveedor.Validate(Proveedor.DV, Node2.AsXmlElement().InnerText);
                    'Name2':
                        Proveedor.Validate(Proveedor."Name 2", Node2.AsXmlElement().InnerText);
                    'BalanceLCY':
                        Evaluate(Proveedor."Balance (LCY)", Node2.AsXmlElement().InnerText, 9);
                    'BalanceDueLCY':
                        Evaluate(Proveedor."Balance Due (LCY)", Node2.AsXmlElement().InnerText, 9);
                    'DocumetnSendingProfile':
                        Proveedor.Validate(Proveedor."Document Sending Profile", Node2.AsXmlElement().InnerText);
                    'SearchName':
                        Proveedor.Validate(Proveedor."Search Name", Node2.AsXmlElement().InnerText);
                    'ICPartnerCode':
                        Proveedor.Validate(Proveedor."IC Partner Code", Node2.AsXmlElement().InnerText);
                    'PurchaserCode':
                        Proveedor.Validate(Proveedor."Purchaser Code", Node2.AsXmlElement().InnerText);
                    'ResponsibilityCenter':
                        Proveedor.Validate(Proveedor."Responsibility Center", Node2.AsXmlElement().InnerText);
                    'Address':
                        Proveedor.Validate(Proveedor.Address, Node2.AsXmlElement().InnerText);
                    'Adress2':
                        Proveedor.Validate(Proveedor."Address 2", Node2.AsXmlElement().InnerText);
                    'CountyRegionCode':
                        Proveedor.Validate(Proveedor."Country/Region Code", Node2.AsXmlElement().InnerText);
                    'City':
                        Proveedor.Validate(Proveedor.City, Node2.AsXmlElement().InnerText);
                    'PostCode':
                        Proveedor.Validate(Proveedor."Post Code", Node2.AsXmlElement().InnerText);
                    'phoneno':
                        Proveedor.Validate(Proveedor."Phone No.", Node2.AsXmlElement().InnerText);
                    'mobilephoneno':
                        Proveedor.Validate(Proveedor."Mobile Phone No.", Node2.AsXmlElement().InnerText);
                    'Email':
                        Proveedor.Validate(Proveedor."E-Mail", Node2.AsXmlElement().InnerText);
                    'HomePage':
                        Proveedor.Validate(Proveedor."Home Page", Node2.AsXmlElement().InnerText);
                    'ouraccountno':
                        Proveedor.Validate(Proveedor."Our Account No.", Node2.AsXmlElement().InnerText);
                    'languajecode':
                        Proveedor.Validate(Proveedor."Language Code", Node2.AsXmlElement().InnerText);
                    'vatregistration':
                        Proveedor.Validate(Proveedor."VAT Registration No.", Node2.AsXmlElement().InnerText);
                    'EORInumber':
                        Proveedor.Validate(Proveedor."EORI Number", Node2.AsXmlElement().InnerText);
                    'taxareacode':
                        Proveedor.Validate(Proveedor."Tax Area Code", Node2.AsXmlElement().InnerText);
                    'paytovendor':
                        Proveedor.Validate(Proveedor."Pay-to Vendor No.", Node2.AsXmlElement().InnerText);
                    'invoicedisccode':
                        Proveedor.Validate(Proveedor."Invoice Disc. Code", Node2.AsXmlElement().InnerText);
                    'pricescalculationmethod':
                        Evaluate(Proveedor."Price Calculation Method", Node2.AsXmlElement().InnerText, 9);
                    'vatbuspostinggroup':
                        Proveedor.Validate(Proveedor."VAT Bus. Posting Group", Node2.AsXmlElement().InnerText);
                    'genbuspostinggroup':
                        Proveedor.Validate(Proveedor."Gen. Bus. Posting Group", Node2.AsXmlElement().InnerText);
                    'currencycode':
                        Proveedor.Validate(Proveedor."Currency Code", Node2.AsXmlElement().InnerText);
                    'prepaymentporcentaje':
                        Evaluate(Proveedor."Prepayment %", Node2.AsXmlElement().InnerText, 9);
                    'paymentmethodcode':
                        Proveedor.Validate(Proveedor."Payment Method Code", Node2.AsXmlElement().InnerText);
                    /*'paymentdayscode':
                        Proveedor.Validate(Proveedor."Payment Days Code", Node2.AsXmlElement().InnerText);
                    'nonpaymnt':
                        Proveedor.Validate(Proveedor."Non-Paymt. Periods Code", Node2.AsXmlElement().InnerText);*/
                    'priority':
                        Evaluate(Proveedor.Priority, Node2.AsXmlElement().InnerText, 9);
                    'preferredbankaccountcode':
                        Proveedor.Validate(Proveedor."Preferred Bank Account Code", Node2.AsXmlElement().InnerText);
                    'partnertype':
                        Evaluate(Proveedor."Partner Type", Node2.AsXmlElement().InnerText, 9);
                    'cashflowpaymenttermscode':
                        Proveedor.Validate(Proveedor."Cash Flow Payment Terms Code", Node2.AsXmlElement().InnerText);
                    'creditorno':
                        Proveedor.Validate(Proveedor."Creditor No.", Node2.AsXmlElement().InnerText);
                    'locationcode':
                        Proveedor.Validate(Proveedor."Location Code", Node2.AsXmlElement().InnerText);
                    'shipmentmethod':
                        Proveedor.Validate(Proveedor."Shipment Method Code", Node2.AsXmlElement().InnerText);
                    'basecalendarcode':
                        Proveedor.Validate(Proveedor."Base Calendar Code", Node2.AsXmlElement().InnerText);
                    'overreceiptcode':
                        Proveedor.Validate(Proveedor."Over-Receipt Code", Node2.AsXmlElement().InnerText);
                end;
            end;
            Proveedor.Insert(true);
        end;
    end;


    //-----------------------------------------Exportar el XML
    procedure XMLExportarProveedor()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        Proveedor: Record Vendor;
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
        Proveedor.FindSet();

        repeat

            ParentNode := XmlElement.Create('Vendor');
            RootNode.add(ParentNode);

            FieldCaption := 'No.';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Proveedor."No.");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);



            FieldCaption := 'Name';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Proveedor.Name);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := Proveedor.FieldCaption(Balance);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.Balance));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'Facebook';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.FacebookProveedor));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Instagram';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.Instagram));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'LinkedIn';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.LinkedIn));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'RUT';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.RUT));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'DV';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.DV));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Name2';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Name 2"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'BalanceLCY';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Balance (LCY)"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'BalanceDueLCY';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Balance Due (LCY)"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'DocumetnSendingProfile';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Document Sending Profile"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'SearchName';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Search Name"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ICPartnerCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."IC Partner Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'PurchaserCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Purchaser Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ResponsibilityCenter';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Responsibility Center"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            //------------------------------------Seccion address y contact


            FieldCaption := 'Address';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.Address));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'Adress2';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Address 2"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'CountyRegionCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Country/Region Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'City';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.City));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'PostCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Post Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'phoneno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'mobilephoneno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Mobile Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Email';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."E-Mail"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'HomePage';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Home Page"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ouraccountno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Our Account No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'languajecode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Language Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //------------------------------------------------Seccion de invoicing
            FieldCaption := 'vatregistration';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."VAT Registration No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'EORInumber';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."EORI Number"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'taxareacode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Tax Area Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'paytovendor';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Pay-to Vendor No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'invoicedisccode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Invoice Disc. Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'pricescalculationmethod';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Price Calculation Method"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'vatbuspostinggroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."VAT Bus. Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'genbuspostinggroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Gen. Bus. Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'currencycode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Currency Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'prepaymentporcentaje';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Prepayment %"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'paymentmethodcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Payment Method Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*

            FieldCaption := 'paymentdayscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Payment Days Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'nonpaymnt';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Non-Paymt. Periods Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            */

            FieldCaption := 'priority';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor.Priority));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'preferredbankaccountcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Preferred Bank Account Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'partnertype';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Partner Type"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'cashflowpaymenttermscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Cash Flow Payment Terms Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'creditorno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Creditor No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            //---------------------------Seccion receiving


            FieldCaption := 'locationcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Location Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'shipmentmethod';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Shipment Method Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'basecalendarcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Base Calendar Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'overreceiptcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Proveedor."Over-Receipt Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until Proveedor.Next() = 0;
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