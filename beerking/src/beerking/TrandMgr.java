package beerking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class TrandMgr {
	private DBConnectionMgr pool;
	
	public TrandMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//update Trand
	public void updateTrand(int usernum,int smalltype) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String typeName="PaleAle";
		switch(smalltype) {
		case 1: typeName="PaleAle";
		break;
		case 2: typeName="Porter";
		break;
		case 3: typeName="Stout";
		break;
		case 4: typeName="Altbier";
		break;
		case 5: typeName="Kolsch";
		break;
		case 6: typeName="Steinbier";
		break;
		case 7: typeName="Dampfbier";
		break;
		case 8: typeName="Weissbier";
		break;
		case 9: typeName="Kellerbier";
		break;
		case 10: typeName="Roggenbier";
		break;
		case 11: typeName="BelgianAle";
		break;
		case 12: typeName="FlandersRedAle";
		break;
		case 13: typeName="PaleLager";
		break;
		case 14: typeName="Helles";
		break;
		case 15: typeName="DarkLager";
		break;
		case 16: typeName="Pilsener";
		break;
		case 17: typeName="Dunkel";
		break;
		case 18: typeName="Schwarzbier";
		break;
		case 19: typeName="Export";
		break;
		case 20: typeName="SteamBeer";
		break;
		case 21: typeName="Bock";
		break;
		case 22: typeName="Rauchbier";
		break;
		case 23: typeName="ViennaLager";
		break;
		case 24: typeName="Marzen";
		break;
		}
		try {
			con = pool.getConnection();
			sql = "update usertrand set "+ typeName +" = "+ typeName + "+1 where usernum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);	
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}	
	
	//trand select
	public TrandBean selectTrand(int usernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		TrandBean bean = new TrandBean();
		try {
			con = pool.getConnection();
			sql = "select * from usertrand where usernum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUsernum(rs.getInt("usernum"));
				bean.setAltbier(rs.getInt("altbier"));
				bean.setBelgianAle(rs.getInt("belgianAle"));
				bean.setBock(rs.getInt("bock"));
				bean.setDampfbier(rs.getInt("dampfbier"));
				bean.setDarkLager(rs.getInt("darkLager"));
				bean.setDunkel(rs.getInt("dunkel"));
				bean.setExport(rs.getInt("export"));
				bean.setFlandersRedAle(rs.getInt("flandersRedAle"));
				bean.setHelles(rs.getInt("helles"));
				bean.setKellerbier(rs.getInt("kellerbier"));
				bean.setKolsch(rs.getInt("kolsch"));
				bean.setMarzen(rs.getInt("marzen"));
				bean.setPaleAle(rs.getInt("paleAle"));
				bean.setPaleLager(rs.getInt("paleLager"));
				bean.setPilsener(rs.getInt("pilsener"));
				bean.setPorter(rs.getInt("porter"));
				bean.setRauchbier(rs.getInt("rauchbier"));
				bean.setRoggenbier(rs.getInt("roggenbier"));
				bean.setSchwarzbier(rs.getInt("schwarzbier"));
				bean.setSteamBeer(rs.getInt("steamBeer"));
				bean.setSteinbier(rs.getInt("steinbier"));
				bean.setStout(rs.getInt("stout"));
				bean.setViennaLager(rs.getInt("viennaLager"));
				bean.setWeissbier(rs.getInt("weissbier"));		
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//trand most select
		public int[] selectMostTrand(int usernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			Hashtable trand = new Hashtable();
			int k = 0;
			int key[] = new int[3];
			try {
				con = pool.getConnection();
				sql = "select * from usertrand where usernum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					while(k<24)
					{
						trand.put(Integer.toString(k), rs.getInt(k+2));	
						k++;
					}
				}
				List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(trand.entrySet());
				Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {

					  public int compare(Map.Entry<String, Integer> e1, Map.Entry<String, Integer> e2)
					  {
						  if (e1.getValue() == e2.getValue()) {
							  return e1.getKey().compareTo(e2.getKey());
						  }else {
							  return e2.getValue().compareTo(e1.getValue());
						  }
					  }
				});
				LinkedHashMap<String, Integer> result = new LinkedHashMap<String, Integer>();
				for (Map.Entry<String, Integer> e : list) {
					result.put(e.getKey(), e.getValue());	
				}  
				Set set = result.keySet();
				Iterator iterator = set.iterator();	
				
				key[0] = Integer.parseInt((String)iterator.next());
				key[1] = Integer.parseInt((String)iterator.next());
				key[2] = Integer.parseInt((String)iterator.next());		

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return key;
		}
		//trand select beer
		public String selectTrandBeer(String typesmall) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			String returnName = "";
			try {
				con = pool.getConnection();
				sql = "select beerEname from beer where typesmall=? ORDER BY RAND() LIMIT 1";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, typesmall);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					returnName = rs.getString("beerEname");
				}		
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return returnName;
		}
		
		//trand select beer file
		public String selectTrandBeerFile(String beerName) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			String filename = "";
			try {
				con = pool.getConnection();
				sql = "select filename from beer where beerEname=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, beerName);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					filename = rs.getString("filename");
				}		
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return filename;
		}
}
