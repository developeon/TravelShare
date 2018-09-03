package reason;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReasonDAO {
	DataSource dataSource;
	
	public ReasonDAO() {
		try {
			InitialContext initContext  = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/TravelShare");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertReason(String userID, String reason) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO REASON VALUES(?, now(), ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, reason);
			pstmt.executeUpdate();
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
	}

	public ArrayList<ReasonDTO> getList(String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReasonDTO> reasonList = null;
		String SQL = "SELECT * FROM REASON WHERE CONCAT(userID, reason) LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			reasonList = new ArrayList<ReasonDTO>();
			while (rs.next()) {
				ReasonDTO reason = new ReasonDTO();
				reason.setUserID(rs.getString("userID"));
				reason.setDeleteDate(rs.getDate("deleteDate"));
				reason.setReason(rs.getString("reason"));
				reasonList.add(reason);
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
		return reasonList;
	}
	
}
