package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	DataSource dataSource;

	public BoardDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/TravelShare");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int write(String writerID, String content, String fileName1, String fileName2, String fileName3,
			String fileName4, String fileName5) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO BOARD VALUES(null, ?, now(), ?, ?, ?, ?, ?, ?, 'N')";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, writerID);
			pstmt.setString(2, content);
			pstmt.setString(3, fileName1);
			pstmt.setString(4, fileName2);
			pstmt.setString(5, fileName3);
			pstmt.setString(6, fileName4);
			pstmt.setString(7, fileName5);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	public ArrayList<BoardDTO> getList(String sort, String search) {
		ArrayList<BoardDTO> boardList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "";
		try {
			if (sort.equals("인기순")) {
				/*SQL = "SELECT * FROM BOARD WHERE content LIKE ? ORDER BY likeCnt DESC, bno ASC";*/
				SQL = "SELECT * FROM\r\n" + 
						"board t1\r\n" + 
						"LEFT JOIN\r\n" + 
						"(SELECT bno, count(*) AS 'count' FROM likes GROUP BY bno) t2\r\n" + 
						"ON t1.bno = t2.bno\r\n" + 
						"WHERE content LIKE ? AND del_chk = 'N' \r\n" + 
						"UNION\r\n" + 
						"SELECT * FROM\r\n" + 
						"board t1\r\n" + 
						"RIGHT JOIN\r\n" + 
						"(SELECT bno, count(*) AS 'count' FROM likes GROUP BY bno) t2\r\n" + 
						"ON t1.bno = t2.bno\r\n" + 
						"WHERE content LIKE ?  AND del_chk = 'N' \r\n" + 
						"ORDER BY count DESC, 1 ASC;";
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
			} else {
				SQL = "SELECT * FROM BOARD WHERE content LIKE ? AND del_chk = 'N' ORDER BY bno DESC";
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + search + "%");
			}
			
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBno(rs.getInt("bno"));
				board.setWriterID(rs.getString("writerID"));
				board.setRegDate(rs.getDate("regDate"));
				board.setContent((rs.getString("content") == null) ? "" : rs.getString("content"));
				board.setFileName1(rs.getString("fileName1"));
				board.setFileName2(rs.getString("fileName2"));
				board.setFileName3(rs.getString("fileName3"));
				board.setFileName4(rs.getString("fileName4"));
				board.setFileName5(rs.getString("fileName5"));
				board.setDel_chk(rs.getString("del_chk"));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}
	
	public int getBoardCnt(String search, String page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			if(page.equals("update")) {
				String SQL = "SELECT COUNT(*) FROM BOARD WHERE content LIKE ? AND del_chk = 'N'";
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + search + "%");
			} else if(page.equals("admin")) {
				String SQL = "SELECT COUNT(*) FROM BOARD WHERE del_chk = 'N'";
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
			}
			else {
				String SQL = "SELECT COUNT(*) FROM BOARD WHERE writerID = ? AND del_chk = 'N'";
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, search);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("COUNT(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
	
	
	
	public BoardDTO getBoard(int bno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = new BoardDTO();
		String SQL = "SELECT * FROM BOARD WHERE bno = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board.setBno(rs.getInt("bno"));
				board.setWriterID(rs.getString("writerID"));
				board.setRegDate(rs.getDate("regDate"));
				board.setContent((rs.getString("content") == null) ? "" : rs.getString("content"));
				board.setFileName1(rs.getString("fileName1"));
				board.setFileName2(rs.getString("fileName2"));
				board.setFileName3(rs.getString("fileName3"));
				board.setFileName4(rs.getString("fileName4"));
				board.setFileName5(rs.getString("fileName5"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return board;
	}
	
	public int delete(int bno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE BOARD SET del_chk = 'Y' WHERE bno = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bno);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int delete(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE BOARD SET del_chk = 'Y' WHERE writerID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public String getfileSrc(String fileName) {
		return "http://localhost:8080/TravelShare/upload/board/" + fileName;
	}

	public int update(String bno, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE BOARD SET content = ? WHERE bno = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, content);
			pstmt.setString(2, bno);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	public ArrayList<BoardDTO> getListAdmin(String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> boardList = null;
		String SQL = "SELECT * FROM BOARD WHERE CONCAT(bno, writerID, content) LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBno(rs.getInt("bno"));
				board.setWriterID(rs.getString("writerID"));
				board.setRegDate(rs.getDate("regDate"));
				board.setContent((rs.getString("content") == null) ? "" : rs.getString("content"));
				board.setDel_chk(rs.getString("del_chk"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}
	
	public ArrayList<Integer> getBnoList(String writerID){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Integer> bnoList = null;
		String SQL = "SELECT * FROM BOARD WHERE writerID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, writerID);
			bnoList = new ArrayList<Integer>();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				bnoList.add(rs.getInt("bno"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return bnoList;
	}
	
	public ArrayList<BoardDTO> getListInMypage(String search, String showUserID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> boardList = null;
		String SQL = "";
		if(search.equals("활동")) {
			SQL = "SELECT * FROM BOARD WHERE writerID = ? AND del_chk='N'";
		} else {
			//search.equasl("좋아요")
			SQL = "SELECT * FROM BOARD\r\n" + 
					"WHERE bno = ANY(SELECT bno FROM LIKES WHERE userID = ?  AND del_chk='N');";
		}
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, showUserID);
			rs = pstmt.executeQuery();
			boardList = new ArrayList<BoardDTO>();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBno(rs.getInt("bno"));
				board.setWriterID(rs.getString("writerID"));
				board.setRegDate(rs.getDate("regDate"));
				board.setContent((rs.getString("content") == null) ? "" : rs.getString("content"));
				board.setFileName1(rs.getString("fileName1"));
				board.setFileName2(rs.getString("fileName2"));
				board.setFileName3(rs.getString("fileName3"));
				board.setFileName4(rs.getString("fileName4"));
				board.setFileName5(rs.getString("fileName5"));
				board.setDel_chk(rs.getString("del_chk"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}
}
