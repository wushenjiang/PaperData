
package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;


import dao.DataDao;
import pojo.Data;
import pojo.Word;

/** 
* @author: connor
* @version：2020年4月15日 上午10:17:55 
* 
*/
public class DataService {

	public List<Word> getData() throws SQLException {
		DataDao dao = new DataDao();
		List<Data>  dataList= dao.getData();
		List<Word> wordList = new ArrayList<Word>();
		String [] names = new String[100000];
		for(Data data:dataList) {
			String name = data.getPapername();
			String[] namestemp = name.split(" ");
			names = (String[]) ArrayUtils.addAll(namestemp, names);
		}
		HashMap<String, Integer> name_value = new HashMap<>();
		//如果键出现过就+1,没有就记为1
		for(String name:names) {
			name_value.put(name, !name_value.containsKey(name)?1:name_value.get(name)+1);
		}
		//keySet()表示全部键
		for(String name:name_value.keySet()) {
			Word word = new Word();
			if(name!=null&&(name_value.get(name)>1)&&(name.length()>4)) {
				word.setName(name);
				word.setValue(name_value.get(name));
				wordList.add(word);
			}

		}
		return wordList;
	}

	public List<Data> getLink(String name) throws SQLException {
		DataDao dao = new DataDao();
		return dao.getLink(name);
	}

}
 