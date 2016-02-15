# Doc Writers
echo "Building the unigramProb Writers PDF ..."
prince --javascript --input-list=../doc_outputs/unigramProb/writers-pdf/prince-file-list.txt -o unigramProb/files/unigramProb_writers_pdf.pdf;
echo "done"

# Doc Designers
echo "Building unigramProb Designers PDF ..."
prince --javascript --input-list=../doc_outputs/unigramProb/designers-pdf/prince-file-list.txt -o unigramProb/files/unigramProb_designers_pdf.pdf;
echo "done"

echo "All done building the PDFs!"
echo "Now build the web outputs: . unigramProb_3_multibuild_web.sh"