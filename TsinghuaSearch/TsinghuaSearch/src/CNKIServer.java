import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.*;
import org.wltea.analyzer.lucene.IKAnalyzer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.*;

/**
 * Created by northli on 2017/12/19.
 */
public class CNKIServer extends HttpServlet {

    public static final int PAGE_RESULT = 10;
    public static final String indexDir = "forIndex";
    private String fieldName[] = {"title", "abstract", "author"};
    private CNKISearcher searcher = null;
    private String prefixHTML = "<font color='red'>";
    private String suffixHTML = "</font>";
    private Analyzer analyzer;
    private HashMap<String, String> word2vec_res;


    public CNKIServer(){
        super();
        analyzer = new SmartChineseAnalyzer();
        searcher = new CNKISearcher(indexDir+"/index");
        searcher.loadGlobals(new String(indexDir + "/global.txt"));
        word2vec_res = new HashMap<String, String>();

    }

    public ScoreDoc[] showList(ScoreDoc[] results, int page) {
        if(results == null || results.length<(page - 1) * PAGE_RESULT){
            return null;
        }
        int start = Math.max((page-1)*PAGE_RESULT, 0);
        int docNum = Math.min(results.length - start, PAGE_RESULT);
        ScoreDoc[] ret=new ScoreDoc[docNum];
        for(int i=0;i<docNum;++i) {
            ret[i] = results[start + i];
        }
        return ret;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        String queryString = request.getParameter("query");
        String pageString = request.getParameter("page");
        String typeString = "IP";
        String typeString2 = request.getParameter("type");
        if(typeString2 != null) {
            typeString = typeString2;
        }
        int page = 1;
        if(pageString != null) {
            page = Integer.parseInt(pageString);
        }
        if(queryString == null) {
            System.out.println("no query");
        }
        else {
            String[] IP = null;
            Integer[] num_serv = null;
            Integer[] port_num = null;
            String[] serv = null;
            String[] state = null;

            if(typeString.equals("IP")) {
                Vector<Port> ports = searcher.search_ip(queryString);
                if (ports != null) {
                    port_num = new Integer[ports.size()];
                    serv = new String[ports.size()];
                    state = new String[ports.size()];
                    for (int i = 0; i < ports.size(); ++i) {
                        port_num[i] = ports.get(i).port_num;
                        serv[i] = ports.get(i).serv;
                        state[i] = ports.get(i).state;
                    }
                }
            } else {
                Vector<String> ips = searcher.search_serv(queryString);
                IP = new String[ips.size()];
                num_serv = new Integer[ips.size()];
                port_num = new Integer[ips.size()];
                for(int i=0;i<ips.size();++i) {
                    IP[i] = ips.get(i);
                    num_serv[i] = searcher.search_ip(IP[i]).size();
                    port_num[i] = searcher.find_port(IP[i], queryString);
                }
            }



//            TopDocs results = null;
//            results = searcher.searchQuery(queryString, 1000);
//            if(results != null) {
//                ScoreDoc[] hits = showList(results.scoreDocs, page);
//                if(hits != null) {
//                    titles = new String[hits.length];
//                    abstracts = new String[hits.length];
//                    authors = new String[hits.length];
//                    for(int i=0;i<hits.length&&i<PAGE_RESULT;++i){
//                        Document doc = searcher.getDoc(hits[i].doc);
//                        titles[i] = doc.get("title");
//                        abstracts[i] = doc.get("abstract");
//                        authors[i] = doc.get("author");
//                        SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter(prefixHTML, suffixHTML);
//                        Highlighter highlighter = new Highlighter(simpleHTMLFormatter, new QueryScorer(searcher.query));
//                        TokenStream tokenStream = analyzer.tokenStream(queryString, new StringReader(titles[i]));
////                        TokenStream tokenStream1 = analyzer.tokenStream(queryString, new StringReader(authors[i]));
//                        try {
//                            String highlightText = highlighter.getBestFragment(tokenStream, titles[i]);
////                            authors[i] = highlighter.getBestFragment(tokenStream1, authors[i]);
//                            titles[i] = highlightText;
//                        } catch (InvalidTokenOffsetsException e) {
////                            e.printStackTrace();
//                        }
//
//                    }
//
//                }
//                else{
//                    System.out.println("page null");
//                }
//
//            }
//            else {
//                System.out.println("result null");
//            }


            request.setAttribute("totalResultsCnt2", (IP == null ? 1 : IP.length));
            request.setAttribute("totalResultsCnt1", (serv == null ? 1 : serv.length));
            request.setAttribute("type", typeString);
            request.setAttribute("numPerPage",PAGE_RESULT);
            request.setAttribute("currentQuery",queryString);
            request.setAttribute("currentPage", page);
            request.setAttribute("IP", IP);
            request.setAttribute("num_serv", num_serv);
            request.setAttribute("port_num", port_num);
            request.setAttribute("serv", serv);
            request.setAttribute("state", state);
            request.getRequestDispatcher("/result.jsp").forward(request,
                    response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        this.doGet(request, response);
    }


}
