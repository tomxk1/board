
			
						<c:forEach items="${boardList}" var="list">
							<tr id="trBody">
								<td align="center">
									<c:forEach items="${boardTypeList }" var="typeList">
										<c:if test="${list.boardType eq typeList.codeId}">
											${typeList.codeName }
										</c:if>
									</c:forEach>
								</td>
								<td>
									${list.boardNum}
								</td>
								<td>
									<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
					