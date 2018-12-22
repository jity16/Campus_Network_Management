import com.sun.org.apache.xpath.internal.operations.Bool;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.similarities.BM25Similarity;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.wltea.analyzer.lucene.IKAnalyzer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import  java.io.*;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

/**
 * Created by northli on 2017/12/19.
 */

class Port {
    public String state;
    public Integer port_num;
    public String serv;

    public Port(Integer num, String ss, String sss) {
        port_num = num;
        state = ss;
        serv = sss;
    }
}

public class CNKISearcher {
    private IndexReader reader;
    private IndexSearcher searcher;
    private Analyzer analyzer;
    private Float avgLength = 1.0f;
    private String fieldName[] = {"title", "abstract", "author"};
    private Float weights[] = {10.0f, 5.0f, 100.0f};
    private Map<String, Float> boost = new HashMap<String, Float>();
    private Map<String, Vector<Port>> hosts = new HashMap<String, Vector<Port>>();
    public Query query;

    public  CNKISearcher(String indexDir) {
//        analyzer = new SmartChineseAnalyzer();
//        for(int i=0;i<fieldName.length;++i)
//            boost.put(fieldName[i], weights[i]);
//        try {
//            reader = DirectoryReader.open(FSDirectory.open(Paths.get(indexDir)));
//            searcher = new IndexSearcher(reader);
//            searcher.setSimilarity(new BM25Similarity());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
        try {
            FileReader reader = new FileReader("data.txt");
            BufferedReader bufferedReader = new BufferedReader(reader);
            String string = null;
            while((string = bufferedReader.readLine()) != null) {
                String[] data = string.split(" ");
                if(data.length != 1) {
                    Vector<Port> ports = new Vector<Port>();
                    for(int i=0;i<data.length / 3;++i) {
                        ports.add(new Port(Integer.parseInt(data[3 * i + 1]), data[3 * i + 2], data[3 * i + 3]));
                    }
                    hosts.put(data[0], ports);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Vector<Port> search_ip(String query) {
        return hosts.get(query);
    }

    public Vector<String> search_serv(String query) {
        Vector<String> result = new Vector<>();
        for(Map.Entry<String, Vector<Port>> entry : hosts.entrySet()) {
            Vector<Port> vv = entry.getValue();
            for(int i=0;i<vv.size();++i) {
                if(vv.get(i).serv.equals(query)) {
                    result.add(entry.getKey());
                    break;
                }
            }
        }
        return result;
    }

    public Integer find_port(String IP, String serv) {
        Vector<Port> VP = hosts.get(IP);
        for(int i=0;i<VP.size();++i) {
            if(VP.get(i).serv.equals(serv)) {
                return VP.get(i).port_num;
            }
        }
        return null;
    }

    public TopDocs searchQuery(String queryString, int maxnum) {
        try {
            MultiFieldQueryParser parser = new MultiFieldQueryParser(fieldName, analyzer, boost);
            query = parser.parse(queryString);

            TopDocs results = searcher.search(query, maxnum);
            System.out.println(results);
            return results;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void loadGlobals(String filename) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filename)));
            String line = reader.readLine();
            avgLength = Float.parseFloat(line);
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Document getDoc(int docID) {
        try{
            return searcher.doc(docID);
        }catch(IOException e){
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CNKISearcher search = new CNKISearcher("forIndex/index");

//        search.loadGlobals("forIndex/global.txt");
//
//        TopDocs results = search.searchQuery("李念实", 50);
//        ScoreDoc[] hits = results.scoreDocs;
//        for (int i = 0; i < hits.length; i++) { // output raw format
//            Document doc = search.getDoc(hits[i].doc);
//            System.out.println("doc=" + hits[i].doc + " score="
//                    + hits[i].score+" title= "+doc.get("title"));
//        }

    }

}
