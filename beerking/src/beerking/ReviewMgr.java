package beerking;
  
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import beerking.DBConnectionMgr;
 
public class ReviewMgr {
	
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/beerking/beerking/WebContent/beerking/uesrimg/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;
	
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	 
	//Review middle get
	public String[] getMiddle(int num) {
		String[] middle = {"Pale Ale",
				"Porter",
				"Altbier",
				"Kolsch",
				"Steinbier",
				"Dampfbier",
				"Weissbier",
				"Kellerbier",
				"Roggenbier",
				"Belgian Ale",
				"Flanders Red Ale",
				"Stout","all"};
		String[] middle2 ={
				"Pale Lager",
				"Helles",
				"Dark Lager",
				"Pilsener",
				"Dunkel",
				"Schwarzbier",
				"Export",
				"Steam Beer",
				"Bock",
				"Rauchbier",
				"Marzen",
				"Vienna Lager", " ","all"
		};
		String[] middlelist = null;
		if(num==1) {
			middlelist = middle;
		}else if(num==2){
			middlelist = middle2;
		}
		return middlelist;
	}
	
	//Review board get
	public ReviewBoardBean getReview(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReviewBoardBean bean = new ReviewBoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from reviewboard where reviewnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);	
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setReviewnum(rs.getInt("reviewnum"));
				bean.setReviewtitle(rs.getString("reviewtitle"));
				bean.setReviewcomment(rs.getString("reviewcomment"));
				bean.setReviewdate(rs.getString("reviewdate"));
				bean.setReviewtime(rs.getString("reviewtime"));
				bean.setUsernum(rs.getInt("usernum"));
				bean.setBeernum(rs.getInt("beernum"));
				bean.setFilenum(rs.getInt("filenum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//Review board insert get
		public int getInsertReview(int costumer){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int num = 0;
			try {
				con = pool.getConnection();
				sql = "select reviewnum from reviewboard where usernum=? order by reviewnum desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, costumer);	
				rs = pstmt.executeQuery();
				if(rs.next()) {
					num=rs.getInt("reviewnum");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return num;
		}
	//Get UserDate2
	public UserDataBean getUser2(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserDataBean bean = new UserDataBean();
		try {
			con = pool.getConnection();
			sql = "select * from userdata where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUsernum(rs.getInt("usernum"));
				bean.setUsergrant(rs.getInt("usergrant"));
				bean.setEmail(rs.getString("email"));
				bean.setPwd(rs.getString("pwd"));
				bean.setNickname(rs.getString("nickname"));
				bean.setName(rs.getString("name"));
				bean.setAddress(rs.getString("address"));
				bean.setTel(rs.getString("tel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//Get UserData1
	public UserDataBean getUser(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserDataBean bean = new UserDataBean();
		try {
			con = pool.getConnection();
			sql = "select * from userdata where usernum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUsernum(rs.getInt("usernum"));
				bean.setUsergrant(rs.getInt("usergrant"));
				bean.setEmail(rs.getString("email"));
				bean.setPwd(rs.getString("pwd"));
				bean.setNickname(rs.getString("nickname"));
				bean.setName(rs.getString("name"));
				bean.setAddress(rs.getString("address"));
				bean.setTel(rs.getString("tel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//file get data
	public FiletableBean getFiledata(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		FiletableBean bean = new FiletableBean();
		try {
			con = pool.getConnection();
			sql = "select * from filetable where filenum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setFilenum(rs.getInt("filenum"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//ReviewBoard List
	public Vector<ReviewBoardBean> getBoardList(String keyWord,int start, int end,String mddlelist){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ReviewBoardBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				if(keyWord.equals("null")||keyWord.equals("")) {
					if(!mddlelist.equals("null")||!mddlelist.equals("")) {
						if(!mddlelist.equals("all")) {
							sql = "select * from reviewboard where (reviewstate LIKE 0 AND beernum IN(select beernum from beer where typesmall = ?)) order by reviewnum desc limit ?,?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, mddlelist);
							pstmt.setInt(2, start);
							pstmt.setInt(3, end);
						}else {
							sql = "select * from reviewboard where reviewstate LIKE 0 order by reviewnum desc limit ?,?";
							pstmt = con.prepareStatement(sql);
							pstmt.setInt(1, start);
							pstmt.setInt(2, end);
						}			
					}else{
						sql = "select * from reviewboard where reviewstate LIKE 0 order by reviewnum desc limit ?,?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
					}
				}else{
				sql = "select * from reviewboard where (reviewtitle LIKE ? AND reviewstate LIKE 0) order by reviewnum desc LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReviewBoardBean bean = new ReviewBoardBean();
					bean.setReviewnum(rs.getInt("reviewnum"));
					bean.setReviewtitle(rs.getString("reviewtitle"));
					bean.setReviewcomment(rs.getString("reviewcomment"));
					bean.setReviewdate(rs.getString("reviewdate"));
					bean.setReviewtime(rs.getString("reviewtime"));
					bean.setUsernum(rs.getInt("usernum"));
					bean.setBeernum(rs.getInt("beernum"));
					bean.setFilenum(rs.getInt("filenum"));
					vlist.addElement(bean); 
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	
	//Get Reply list
	public Vector<ReplyBean> getReplylist(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ReplyBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select * from reply where (reviewnum = ? AND replystate LIKE 0)"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReplyBean bean = new ReplyBean();
					bean.setUsernum(rs.getInt("usernum"));
					bean.setReplycomment(rs.getString("replycomment"));
					bean.setReplynum(rs.getInt("replynum"));
					bean.setReplydate(rs.getString("replydate"));
					bean.setReviewnum(rs.getInt("reviewnum"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

	//Review Like count
	public int getReviewLikecount(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count = 0;
			try {
				con = pool.getConnection();
				sql = "select count(*) FROM reviewlike JOIN reviewboard where reviewlike.reviewnum = reviewboard.reviewnum AND reviewboard.reviewstate = 0 AND reviewlike.reviewnum = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return count;
		}
		
	//Review Average rating
	public double ReviewAverageRation(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			double average = 0;
			int sum = 0;
			int count = 0;
			try {
				con = pool.getConnection();
				sql = "select reviewscore from reviewgrade where reviewnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					int score = rs.getInt("reviewscore");
					sum = sum + score;
					count = count +1;
				}
				average = (double)sum/(double)count;
				if(sum==0&&count==0) {
					average = 0;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return average;
		}

	//Reply Like count
		public int getReplyLikecount(int num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int count = 0;
				try {
					con = pool.getConnection();
					sql = "select count(*) from replylike where replynum LIKE ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						count =rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return count;
			}
		
		//Reviewlike max num
		public int getMaxReviewNum() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int Maxcount =0;
			int Max=0;
			try {
				con = pool.getConnection();
				sql = "SELECT counted,reviewnum FROM(SELECT reviewnum, COUNT(*) AS counted FROM reviewlike GROUP BY reviewnum) a order by counted desc limit 1;";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
				Max = rs.getInt(1);
				Maxcount = rs.getInt(2);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return Maxcount;
		}
		
		//Get total count
		public int getTotalCount(String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if(keyWord.equals("null")||keyWord.equals("")) {
					sql = "select count(*) from reviewboard where reviewstate LIKE 0";
					pstmt = con.prepareStatement(sql);
				}else {
					sql = "select count(*) from reviewboard where (reviewtitle like ? AND reviewstate LIKE 0)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
				}
				rs = pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//Get total count type
		public int getTotalCountType(int chmiddle,int middle) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			String middleArray[] = getMiddle(chmiddle);
			String typesmall = middleArray[middle];
			try {
				con = pool.getConnection();
				if(!typesmall.equals("all")) {
					sql = "select count(*) from beer where typesmall = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, typesmall);
				}else {
					sql = "select count(*) from reviewboard";
					pstmt = con.prepareStatement(sql);
				}
				rs = pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
	
		//getBeer data
		public BeerBean getBeerdata(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			BeerBean bean = new BeerBean();
			try {
				con = pool.getConnection();
				sql = "select * from beer where beernum= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setBeernum(rs.getInt("beernum"));
					bean.setBeerEname(rs.getString("beerename"));
					bean.setBeerKname(rs.getString("beerkname"));
					bean.setTypebig(rs.getString("typebig"));
					bean.setTypesmall(rs.getString("typesmall"));
					bean.setAlchol(rs.getDouble("alchol"));
					bean.setCompany(rs.getString("company"));
					bean.setCountry(rs.getString("country"));
					bean.setFilename(rs.getString("filename"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
		//like insert
		public void insertLike(int reviewnum,int usernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert reviewlike(reviewnum, usernum) values(?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				pstmt.setInt(2, usernum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//like delete
		public void deleteLike(int reviewnum,int usernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from reviewlike where reviewnum = ? AND usernum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				pstmt.setInt(2, usernum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//insert reviewgrade
		public void insertReviewgrade(int num,int reviewnum,int usernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert reviewgrade(reviewscore,usernum, reviewnum) values(?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setInt(2, usernum);
				pstmt.setInt(3, reviewnum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//delete reviewgrade
		public void deleteReviewgrade(int reviewnum,int usernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from reviewgrade where reviewnum = ? AND usernum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				pstmt.setInt(2, usernum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//insert reply
		public void insertReply(String comment,int usernum,int reviewnum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert reply(replycomment,replydate,usernum,reviewnum) values(?,now(),?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, comment);
				pstmt.setInt(2, usernum);
				pstmt.setInt(3, reviewnum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//delete reply
		public void deleteReply(int reviewnum, int usernum,int replynum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update reply set replystate = 1 where reviewnum = ? AND usernum = ? AND replynum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				pstmt.setInt(2, usernum);
				pstmt.setInt(3, replynum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		
		//insert rereply
				public void insertRereply(String comment,int usernum,int replynum) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "insert rereply(rereplycomment,rereplydata,usernum,replynum) values(?,now(),?,?)";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, comment);
						pstmt.setInt(2, usernum);
						pstmt.setInt(3, replynum);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
					return;
				}
				
				//delete rereply
				public void deleteRereply(int replynum, int usernum,int rereplynum) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "delete from rereply where replynum = ? AND usernum = ? AND rereplynum =?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, replynum);
						pstmt.setInt(2, usernum);
						pstmt.setInt(3, rereplynum);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
					return;
				}
				
			//get rereply list
			public Vector<RereplyBean> getRereplylist(int num) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<RereplyBean> vlist = new Vector<>();
					try {
						con = pool.getConnection();
						sql = "select * from rereply where replynum = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							RereplyBean bean = new RereplyBean();
							bean.setUsernum(rs.getInt("usernum"));
							bean.setRereplycomment(rs.getString("rereplycomment"));
							bean.setReplynum(rs.getInt("replynum"));
							bean.setRereplydata(rs.getString("rereplydata"));
							bean.setRereplynum(rs.getInt("rereplynum"));
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
			
			//reply like insert
			public void ReplyinsertLike(int replynum,int usernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "insert replylike(replynum, usernum) values(?,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, replynum);
					pstmt.setInt(2, usernum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
			
			//reply like delete
			public void ReplydeleteLike(int replynum,int usernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "delete from replylike where replynum = ? AND usernum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, replynum);
					pstmt.setInt(2, usernum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
			
			//check like grade
			public boolean checkLike(String check,int usernum,String check2,int num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "SELECT * FROM "+check+" WHERE (usernum like ? AND "+check2+" like "+num+" )";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, usernum);
					rs = pstmt.executeQuery();
					if(rs.next()==true) {
						flag = true;
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return flag;
			}
			//writer beardata get
			public Vector<BeerBean> getWriterBeardata(String middle,String keyWord) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<BeerBean> vlist = new Vector<>();
				try {
					con = pool.getConnection();
					if(keyWord.equals("null")||keyWord.equals("")) {
					sql = "select * from beer where typesmall like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+middle+"%");
					}else{
					sql = "select * from beer where beerename like ? or beerkname like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
					pstmt.setString(2, "%"+keyWord+"%");
					}
					rs = pstmt.executeQuery();
					while(rs.next()) {
						BeerBean bean = new BeerBean();
						bean.setBeernum(rs.getInt("beernum"));
						bean.setBeerEname(rs.getString("beerEname"));
						bean.setBeerKname(rs.getString("beerKname"));
						bean.setTypebig(rs.getString("typebig"));
						bean.setTypesmall(rs.getString("typesmall"));
						bean.setAlchol(rs.getDouble("alchol"));
						bean.setCompany(rs.getString("company"));
						bean.setCountry(rs.getString("country"));
						bean.setFilename(rs.getString("filename"));
						vlist.addElement(bean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
			//writer beer data get
			public BeerBean SmallbeerDataGet(String smallbeer) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				BeerBean bbean = new BeerBean();
				try {
					con = pool.getConnection();
					sql = "select * from beer where beerEname =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, smallbeer);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						bbean.setBeernum(rs.getInt("beernum"));
						bbean.setBeerEname(rs.getString("beerEname"));
						bbean.setBeerKname(rs.getString("beerKname"));
						bbean.setTypebig(rs.getString("typebig"));
						bbean.setTypesmall(rs.getString("typesmall"));
						bbean.setAlchol(rs.getDouble("alchol"));
						bbean.setCompany(rs.getString("company"));
						bbean.setCountry(rs.getString("country"));
						bbean.setFilename(rs.getString("filename"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return bbean;
			}
			
			//insert Writer
			public void insertWriter(String reviewtitle,String reviewcomment,int usernum,int beernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "insert reviewboard(reviewtitle, reviewcomment,reviewdate,reviewtime,usernum,beernum,filenum,filename,reviewstate) values(?,?,now(),now(),?,?,5,?,0)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, reviewtitle);
					pstmt.setString(2, reviewcomment);
					pstmt.setInt(3, usernum);
					pstmt.setInt(4, beernum);
					pstmt.setString(5, "첨부파일이 없습니다.");
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
			//get Wrtier
			public ReviewBoardBean getWriter(int num) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				ReviewBoardBean rbean = new ReviewBoardBean();
				try {
					con = pool.getConnection();
					sql = "select * from reviewboard where reviewnum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						rbean.setReviewnum(rs.getInt("reviewnum"));
						rbean.setReviewtitle(rs.getString("reviewtitle"));
						rbean.setReviewcomment(rs.getString("reviewcomment"));
						rbean.setReviewdate(rs.getString("reviewdate"));
						rbean.setReviewtime(rs.getString("reviewtime"));
						rbean.setUsernum(rs.getInt("usernum"));
						rbean.setBeernum(rs.getInt("beernum"));
						rbean.setFilenum(rs.getInt("filenum")); 
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return rbean;
			}
			//writer update
			public void updateWriter(String reviewtitle,String reviewcomment,int usernum,int beernum,int reviewnum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "update reviewboard set reviewtitle = ?, reviewcomment = ?, usernum = ?, beernum = ?, reviewdate=now(), reviewtime=now() where reviewnum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, reviewtitle);
					pstmt.setString(2, reviewcomment);
					pstmt.setInt(3, usernum);
					pstmt.setInt(4, beernum);
					pstmt.setInt(5, reviewnum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
			//writer delete
			public void WriterDelete(int reviewnum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "update reviewboard set reviewstate=1 where reviewnum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, reviewnum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
}
