"""
    目标：完成登录业务层实现
"""

# 导包 unittest ApiLogin
import unittest
from api.api_login import ApiLogin
from parameterized import parameterized
from tools.read_json import ReadJson


# 读取数据函数
def get_data():
    datas = ReadJson("login_more.json").read_json()
    # 新建空列表，添加读取json数据
    arrs = []
    # 使用遍历获取所有的value
    for data in datas.values():
        arrs.append((data.get("url"),
                     data.get("mobile"),
                     data.get("code"),
                     data.get("expect_result"),
                     data.get("status_code")))
    return arrs

# 新建测试类
class TestLogin(unittest.TestCase):
    # 新建测试方法
    @parameterized.expand(get_data())
    def test_login(self, url,mobile, code, expect_result, status_code):
        # 暂时存放数据 url mobile code
        # url = "http://ttapi.research.itcast.cn/app/v1_0/authorizations"
        # mobile = "18610453007"
        # code = "882477"

        # 调用登录方法
        s = ApiLogin().api_post_login(url, mobile, code)

        # 调试使用
        print("查看响应结果：", s.json())

        # 断言 响应信息 及 状态码
        # self.assertEquals("OK", s.json()['message'])
        self.assertEquals(expect_result, s.json()['message'])
        # 断言响应状态码
        # self.assertEquals(201, s.status_code)
        self.assertEquals(status_code, s.status_code)


if __name__ == '__main__':
    unittest.main()

"""
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NTAyMjMxMjgsInVzZXJfaWQiOjgsInJlZnJlc2giOmZhbHNlfQ.96Xo6j69bADB_zt0Wcdn7dml1Myd4FcNji_fsF65Rbw

"""