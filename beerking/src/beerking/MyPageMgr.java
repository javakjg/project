package beerking;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;


public class MyPageMgr {
	
	private DBConnectionMgr pool;
	
	public MyPageMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//like beer List(���� ���ƿ� �� ����)
		public Vector<BeerBean> getbeer(int usernum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<BeerBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select b.filename, b.beerename from favorite f join beer b on b.beernum = f.beernum where usernum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					BeerBean bean = new BeerBean();
					bean.setBeerEname(rs.getString("beerename"));//�����̸�
					bean.setFilename(rs.getString("filename"));//���������̸�
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//like beer List date(�ֱ� ���ƿ� ����)
				public Vector<BeerBean> getRecentBeer(int usernum)
				{
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<BeerBean> vlist = new Vector<>();
					try {
						con = pool.getConnection();
						sql = "select b.filename, b.beerename from favorite f join beer b on b.beernum = f.beernum where usernum = ? order by f.favnum desc";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, usernum);
						rs = pstmt.executeQuery();
						while(rs.next())
						{
							BeerBean bean = new BeerBean();
							bean.setBeerEname(rs.getString("beerename"));//�����̸�
							bean.setFilename(rs.getString("filename"));//���������̸�
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
		
		//get reviewBoard list(���ƿ��� ����(��������+�����̸�)) 
		  public Vector<ReviewBoardBean> getReviewlike(int usernum)
		  {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;
		    Vector<ReviewBoardBean> vlist = new Vector<>();
		    try {
		      con = pool.getConnection();//����Խ��� + �������ƿ� + �������̺� ����
		      sql = "select b.reviewnum, b.reviewtitle, r.filename from reviewboard b join reviewlike l on l.reviewnum = b.reviewnum join beer r on r.beernum = b.beernum where l.usernum = ?";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setInt(1, usernum);
		      rs = pstmt.executeQuery();
		      while(rs.next())
		      {
		        ReviewBoardBean bean = new ReviewBoardBean();
		        bean.setReviewnum(rs.getInt("reviewnum"));//����ѹ�
		        bean.setReviewtitle(rs.getString("reviewtitle"));//����Ÿ��Ʋ(favorite)
		        bean.setFilename(rs.getString("filename"));// ���� �ø� ����
		        vlist.addElement(bean);
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		      pool.freeConnection(con, pstmt, rs);
		    }
		    return vlist;
		  }
		  
		//get reviewBoard list date(�ֱ� ���ƿ��� ����(��������+�����̸�)) 
		  public Vector<ReviewBoardBean> getRecentReviewlike(int usernum)
		  {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;
		    Vector<ReviewBoardBean> vlist = new Vector<>();
		    try {
		      con = pool.getConnection();//����Խ��� + �������ƿ� + �������̺� ����
		      sql = "select b.reviewnum, b.reviewtitle, r.filename from reviewboard b join reviewlike l on l.reviewnum = b.reviewnum join beer r on r.beernum = b.beernum where l.usernum = ? order by l.reviewlikenum desc";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setInt(1, usernum);
		      rs = pstmt.executeQuery();
		      while(rs.next())
		      {
		        ReviewBoardBean bean = new ReviewBoardBean();
		        bean.setReviewnum(rs.getInt("reviewnum"));//����ѹ�
		        bean.setReviewtitle(rs.getString("reviewtitle"));//����Ÿ��Ʋ(favorite)
		        bean.setFilename(rs.getString("filename"));// ���� �ø� ����
		        vlist.addElement(bean);
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		      pool.freeConnection(con, pstmt, rs);
		    }
		    return vlist;
		  }
		
		//get myReview (���� �� ���� + ����¡ó��)
		public Vector<ReviewBoardBean> getMyReview(int usernum, int start, int end)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ReviewBoardBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select reviewnum, reviewtitle, reviewdate, reviewstate from reviewboard WHERE usernum = ? order by reviewnum, reviewtitle LIMIT ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);//������ �Ǵ� �����ѹ�
				pstmt.setInt(2, start); //������ ����
				pstmt.setInt(3, end); //�ҷ� �� ������ ��(numPerPage)
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ReviewBoardBean bean = new ReviewBoardBean();
					bean.setReviewnum(rs.getInt("reviewnum"));//����ѹ�-------
					bean.setReviewtitle(rs.getString("reviewtitle"));//���� ���� -----
					bean.setReviewdate(rs.getString("reviewdate"));//���� ��¥-------
					bean.setReviewstate(rs.getInt("reviewstate"));//���� ��������
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//get myReply (���� �� ����)
		public Vector<ReplyBean> getMyReply(int usernum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ReplyBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select r.reviewnum, r.reviewtitle, p.replycomment, p.replynum from reply p join reviewboard r on p.reviewnum = r.reviewnum where p.usernum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ReplyBean bean = new ReplyBean();
					bean.setReviewnum(rs.getInt("reviewnum"));
					bean.setReviewtitle(rs.getString(2));
					bean.setReplycomment(rs.getString(3));
					bean.setReplynum(rs.getInt(4));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

		//get MyReviewLikeCount(�� ����� ���ƿ� ��)
		public int getlike(int reviewnum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int likecount = 0;
			try {
				con = pool.getConnection();
				sql = "select count(usernum) from reviewlike where reviewnum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				rs = pstmt.executeQuery();
				if(rs.next())
					likecount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return likecount;
		}

		//get MyReviewScore (�� ����� ����)
		public double getrevGrade(int reviewnum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			double reviGrade = 0.0;//�Ҽ����� �÷����� ����
			try {
				con = pool.getConnection();
				sql = "select avg(reviewscore) from reviewgrade where reviewnum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewnum);
				rs = pstmt.executeQuery();
				if(rs.next())
					reviGrade = rs.getDouble(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return reviGrade;
		}
		
		//get MyReplyCount (�� ��� ���ƿ� ��)
		public int getReLike(int replynum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int repcount = 0;
			try {
				con = pool.getConnection();
				sql = "select count(usernum) from replylike where replynum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, replynum);
				rs = pstmt.executeQuery();
				if(rs.next())
					repcount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return repcount;
		}
		
		
		//get MyReviewCount (����¡ ó��Mgr�� ���� ���� �� ������ �� ����)
		public int getTotalCount(int usernum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try
			{
				con = pool.getConnection();
				sql = "select count(*) from reviewboard where usernum =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);
				rs = pstmt.executeQuery();
				if(rs.next())
					totalCount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}

}
