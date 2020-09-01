# 导包 unittest ApiClannels
import unittest
from api.api_channels import ApiChannels
from parameterized import parameterized

from tools.read_json import ReadJson


def get_data():
    data = ReadJson("channel.json").read_json()
    # 新建空列表，添加读取json数据
    arrs = []
    arrs.append((data.get("url"),
                 data.get("headers"),
                 data.get("expect_result"),
                 data.get("status_code")))
    return arrs


# 新建测试类 继承
class TestClannels(unittest.TestCase):
    # 新建测试方法
    @parameterized.expand(get_data())
    def test_channels(self, url, headers, expect_result, status_code):
        # 临时数据
        # url = "http://ttapi.research.itcast.cn/app/v1_0/user/channels"

        # 提示：token之前有个空格和Bearer
        # headers = {"Content-Type": "application/json","Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NTAyNTA4NDIsInVzZXJfaWQiOjU3LCJyZWZyZXNoIjpmYWxzZX0.MB2ZK5c8-VJHdA40r4ijLyAmIbPMpi_40tpeo3Wj4wk"}

        # 调用获取用户频道列表方法
        r = ApiChannels().api_get_channels(url, headers)

        # 调试信息 打印响应结果
        print(r.json())

        # 断言 状态码
        # self.assertEquals(200, r.status_code)

        # 使用参数化
        self.assertEquals(status_code, r.status_code)

        # 断言 响应信息
        # self.assertEquals("OK", r.json()['message'])

        # 使用参数化
        self.assertEquals(expect_result, r.json()['message'])


if __name__ == '__main__':
    unittest.main()