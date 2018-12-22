import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.search.similarities.BM25Similarity;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;
import sun.misc.Version;

import java.io.*;
import java.nio.file.Paths;

/**
 * Created by northli on 2017/12/19.
 */
public class CNKIIndexer {
//    private SmartChineseAnalyzer analyzer;
    private static IndexWriter indexWriter;
    private float averageLength = 1.0f;
    private String fieldName[] = {"title", "abstract", "author"};

    public CNKIIndexer(String indexDir) {
        Analyzer analyzer = new SmartChineseAnalyzer();
        try{
            IndexWriterConfig iwc = new IndexWriterConfig(analyzer);
            Directory dir = FSDirectory.open(Paths.get(indexDir));
            iwc.setSimilarity(new BM25Similarity());
            iwc.setOpenMode(IndexWriterConfig.OpenMode.CREATE_OR_APPEND);
            indexWriter = new IndexWriter(dir, iwc);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void saveGlobals(String filename) {
        try {
            PrintWriter pw = new PrintWriter(new File(filename));
            pw.println(averageLength);
            pw.close();
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    public void doIndex(String filename) {
        try {
            String forPath = "/Users/northli/Downloads/IR/input/data_3.txt";
            FileReader reader = new FileReader(forPath);
            BufferedReader bufferedReader = new BufferedReader(reader);
            String string = null;
            Integer t = 0, i = 0;
            Document document = new Document();
            while((string = bufferedReader.readLine()) != null) {
                document.add(new TextField(fieldName[t], string, Field.Store.YES));
                t++;
                if(t == 3) {
                    indexWriter.addDocument(document);
                    document = new Document();
                    t = 0;
                    i ++;
                }
                if(i % 500 == 0) {
                    System.out.println(i);
                }
//                System.out.println(i);
            }
            System.out.println("total "+indexWriter.numDocs()+" documents");
            indexWriter.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    public static void main(String[] args) {
        CNKIIndexer indexer = new CNKIIndexer("forIndex/index");
        indexer.doIndex("");
        indexer.saveGlobals("forIndex/global.txt");
    }

}
