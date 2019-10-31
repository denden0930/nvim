from .base import Base

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'callneco'           # なまえ
        self.mark = '[neco]'               # mark のなまえ

    def gather_candidates(self, context):
      return ["start",
              "autocomplete"
              "check_box",
              "digest",
              "except",
              "flase",
              "gender",
              "man",
              "parts",
              "remember",
              "request",
              "request.path_info",
              "session",
              "unless",
              "woman",
              "end"]  # ポップアップのリスト
