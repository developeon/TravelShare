package report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReportDAO {
	DataSource dataSource;

	public ReportDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/TravelShare");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insert(String reporter, int targetBno, int reportType) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO REPORT VALUES(null, ?, ?, ?, now(), '미처리')";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reporter);
			pstmt.setInt(2, targetBno);
			pstmt.setInt(3, reportType);
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

	public int delete(String reporter) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM REPORT WHERE reporter = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reporter);
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

	public ArrayList<ReportDTO> getList(String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReportDTO> reportList = null;
		String SQL = "SELECT * FROM REPORT WHERE CONCAT(rno, reporter, targetBno, reportType, isCheck) LIKE ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			reportList = new ArrayList<ReportDTO>();
			while (rs.next()) {
				ReportDTO report = new ReportDTO();
				report.setRno(rs.getInt("rno"));
				report.setReporter(rs.getString("reporter"));
				report.setTargetBno(rs.getInt("targetBno"));
				report.setReportType(rs.getInt("reportType"));
				report.setReportDate(rs.getDate("reportDate"));
				report.setIsCheck(rs.getString("isCheck"));
				reportList.add(report);
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
		return reportList;
	}

	public int update(String rno, String state) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE REPORT SET isCheck = ? WHERE rno = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, state);
			pstmt.setString(2, rno);
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

}
