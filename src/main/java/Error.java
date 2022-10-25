// 500 ERRER
// "ERROR" dispatch for POST "/error", parameters={masked} 
// org.apache.ibatis.binding.BindingException 
// -> DAO 쪽 문제 오타있는지 확인. mapper.xml 이랑 DAO 파라미터값이 일치하는가?

// 404 ERROR
// 페이지 찾을 수 없음

// java.sql.SQLException
// Parameter index out of range
// xmlMapper `id` 오타났엇음.


// NullPointerException 
// Cannot invoke "java.lang.Integer.intValue()" because "userId" is null
// userId 값이 null 이였음.