package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	DataSource dataSource;
	
	public UserDAO() {
		try {
			InitialContext initContext  = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/TravelShare");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ? AND userPassword = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1; //로그인 성공
			}
			return 0; //사용자가 존재하지 않거나 비밀번호가 틀린 경우
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
		return -1; //DB오류
	}
	
	public int registerCheck(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0; //이미 존재하는 회원
			}
			else {
				return 1; //가입 가능한 회원 ID
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
		return -1; //DB오류
	}
	
	public int register(String userID, String userPassword, String userEmail, String userNickName, String userProfile, String userIntro) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?,?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userNickName);
			pstmt.setString(5, userProfile);
			pstmt.setString(6, userIntro);
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
	
	public UserDTO getUser(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO user = new UserDTO();
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserProfile(rs.getString("userProfile"));
				user.setUserIntro(rs.getString("userIntro"));
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
		return user;
	}
	
	public ArrayList<UserDTO> getList(String search) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserDTO> userList = null;
		String SQL = "SELECT * FROM USER WHERE CONCAT(userID,userEmail,userNickname,userIntro) LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			userList = new ArrayList<UserDTO>();
			while (rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserProfile(rs.getString("userProfile"));
				user.setUserIntro(rs.getString("userIntro"));
				userList.add(user);
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
		return userList;
	}
	
	public ArrayList<UserDTO> getList(int bno) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserDTO> userList = null;
		String SQL = "SELECT * FROM USER u, LIKES l\r\n" + 
				"WHERE u.userID = l.userID AND bno = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bno);
			rs = pstmt.executeQuery();
			userList = new ArrayList<UserDTO>();
			while (rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserProfile(rs.getString("userProfile"));
				user.setUserIntro(rs.getString("userIntro"));
				userList.add(user);
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
		return userList;
	}
	
	public int update(String userID, String userPassword, String userNickName, String userProfile, String userIntro) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE USER SET userPassword = ?, userNickName = ?, userProfile = ?, userIntro = ? WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userNickName);
			pstmt.setString(3, userProfile);
			pstmt.setString(4, userIntro);
			pstmt.setString(5, userID);
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
	
	public String getProfile(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userProfile FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userProfile").equals("")) {
					return "http://localhost:8080/TravelShare/images/icon.png";
				}
				return "http://localhost:8080/TravelShare/upload/profile/" + rs.getString("userProfile");
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
		return "http://localhost:8080/TravelShare/images/icon.png";
	}
	
	public int delete(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM USER WHERE userID = ?";
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
	
	public ArrayList<UserDTO> getUserCard(String search) { // 사랑해 소언아 너는 정말 어려운걸하고있구나... - 515호 찌랭이 도가연
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserDTO> userList = null;
		String SQL = "SELECT * FROM USER WHERE userID LIKE ? OR userEmail LIKE ? OR userNickname LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
			rs = pstmt.executeQuery();
			userList = new ArrayList<UserDTO>();
			while (rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserProfile(rs.getString("userProfile"));
				user.setUserIntro(rs.getString("userIntro"));
				userList.add(user);
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
		return userList;
	}
	
	public int getUserCnt(String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT COUNT(*) FROM USER WHERE userID LIKE ? OR userEmail LIKE ? OR userNickname LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + search + "%");
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
	
	public String getUserNickName(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userNickname FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("userNickname");
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
		return "";
	}

	public int registerEmailCheck(String userEmail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userEmail = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next() || userEmail.equals("")) {
				return 0; //이미 존재하는 회원
			}
			else {
				return 1; //가입 가능한 회원 ID
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
		return -1; //DB오류
	}
	
}
