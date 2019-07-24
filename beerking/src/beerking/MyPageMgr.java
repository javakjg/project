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
	
	//like beer List(내가 좋아요 한 맥주)
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
					bean.setBeerEname(rs.getString("beerename"));//맥주이름
					bean.setFilename(rs.getString("filename"));//맥주파일이름
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//like beer List date(최근 좋아요 맥주)
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
							bean.setBeerEname(rs.getString("beerename"));//맥주이름
							bean.setFilename(rs.getString("filename"));//맥주파일이름
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
		
		//get reviewBoard list(좋아요한 리뷰(리뷰제목+파일이름)) 
		  public Vector<ReviewBoardBean> getReviewlike(int usernum)
		  {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;
		    Vector<ReviewBoardBean> vlist = new Vector<>();
		    try {
		      con = pool.getConnection();//리뷰게시판 + 리뷰좋아요 + 파일테이블 조인
		      sql = "select b.reviewnum, b.reviewtitle, r.filename from reviewboard b join reviewlike l on l.reviewnum = b.reviewnum join beer r on r.beernum = b.beernum where l.usernum = ?";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setInt(1, usernum);
		      rs = pstmt.executeQuery();
		      while(rs.next())
		      {
		        ReviewBoardBean bean = new ReviewBoardBean();
		        bean.setReviewnum(rs.getInt("reviewnum"));//리뷰넘버
		        bean.setReviewtitle(rs.getString("reviewtitle"));//리뷰타이틀(favorite)
		        bean.setFilename(rs.getString("filename"));// 리뷰어가 올린 파일
		        vlist.addElement(bean);
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		      pool.freeConnection(con, pstmt, rs);
		    }
		    return vlist;
		  }
		  
		//get reviewBoard list date(최근 좋아요한 리뷰(리뷰제목+파일이름)) 
		  public Vector<ReviewBoardBean> getRecentReviewlike(int usernum)
		  {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = null;
		    Vector<ReviewBoardBean> vlist = new Vector<>();
		    try {
		      con = pool.getConnection();//리뷰게시판 + 리뷰좋아요 + 파일테이블 조인
		      sql = "select b.reviewnum, b.reviewtitle, r.filename from reviewboard b join reviewlike l on l.reviewnum = b.reviewnum join beer r on r.beernum = b.beernum where l.usernum = ? order by l.reviewlikenum desc";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setInt(1, usernum);
		      rs = pstmt.executeQuery();
		      while(rs.next())
		      {
		        ReviewBoardBean bean = new ReviewBoardBean();
		        bean.setReviewnum(rs.getInt("reviewnum"));//리뷰넘버
		        bean.setReviewtitle(rs.getString("reviewtitle"));//리뷰타이틀(favorite)
		        bean.setFilename(rs.getString("filename"));// 리뷰어가 올린 파일
		        vlist.addElement(bean);
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		      pool.freeConnection(con, pstmt, rs);
		    }
		    return vlist;
		  }
		
		//get myReview (내가 쓴 리뷰 + 페이징처리)
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
				pstmt.setInt(1, usernum);//기준이 되는 유저넘버
				pstmt.setInt(2, start); //페이지 시작
				pstmt.setInt(3, end); //불러 올 페이지 수(numPerPage)
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ReviewBoardBean bean = new ReviewBoardBean();
					bean.setReviewnum(rs.getInt("reviewnum"));//리뷰넘버-------
					bean.setReviewtitle(rs.getString("reviewtitle"));//리뷰 제목 -----
					bean.setReviewdate(rs.getString("reviewdate"));//리뷰 날짜-------
					bean.setReviewstate(rs.getInt("reviewstate"));//리뷰 삭제여부
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//get myReply (내가 쓴 리플)
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

		//get MyReviewLikeCount(내 리뷰글 좋아요 수)
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

		//get MyReviewScore (내 리뷰글 평점)
		public double getrevGrade(int reviewnum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			double reviGrade = 0.0;//소수점을 늘려야할 수도
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
		
		//get MyReplyCount (내 댓글 좋아요 수)
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
		
		
		//get MyReviewCount (페이징 처리Mgr을 위한 내가 쓴 리뷰의 총 갯수)
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
