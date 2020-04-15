
package dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import pojo.Data;
import utils.DataSourceUtils;

/** 
* @author: connor
* @version：2020年4月15日 上午10:19:06 
* 
*/
public class DataDao {

	public List<Data> getData() throws SQLException {
		QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from data ";
		List<Data> dataList = queryRunner.query(sql, new BeanListHandler<Data>(Data.class));
		return dataList;
		
		
	}

	public List<Data> getLink(String name) throws SQLException {
		QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from data where papername like ?";
		List<Data> dataList = queryRunner.query(sql, new BeanListHandler<Data>(Data.class),"%"+name+"%");
		return dataList;
	}

}
 