<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<tiles:insertAttribute name="header" />
<body>
<div class="wrap">
    <tiles:insertAttribute name = "left-nav"/>

    <div class="content-wrapper" id ="contents">
        <tiles:insertAttribute name = "content"/>
    </div>
</div>
<div class="copyright">Copyright © 2022 유비씨엔(주) All Rights Reserved.</div>

</body>
</html>