import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';

import { AuthService } from './auth.service';

import { CreateUserDto, LoginUserDto } from './dto';
import { User } from './entities/auth.entity';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Auth, GetUser, RoleProtected } from './decorators';
import { ValidRoles } from './interfaces';
import { AuthGuard } from '@nestjs/passport';
import { UserRoleGuard } from './guards';

@ApiTags('Authenticacion')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiOperation({ summary: 'Registro de un nuevo usuario' })
  @ApiResponse({
    status: 201,
    description: 'El usuario ha sido creado correctamente',
    type: User,
  })
  @ApiResponse({
    status: 400,
    description: 'Bad Request',
  })
  @Post('register')
  createUser(@Body() createUserDto: CreateUserDto) {
    return this.authService.create(createUserDto);
  }

  @ApiOperation({ summary: 'Inicio de sesión de un usuario' })
  @ApiResponse({
    status: 200,
    description: 'El usuario ha iniciado sesión correctamente',
    type: User,
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Post('login')
  loginUser(@Body() loginUserDto: LoginUserDto) {
    return this.authService.login(loginUserDto);
  }

  @Get('users')
  @RoleProtected(ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  getUsers() {
    return this.authService.getAllUsers();
  }
  @ApiOperation({ summary: 'Verificar el estado de autenticación del usuario' })
  @ApiBearerAuth()
  @ApiResponse({
    status: 200,
    description: 'El estado de autenticación ha sido verificado correctamente',
    type: User,
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get('check-status')
  @Auth()
  checkAuthStatus(@GetUser() user: User) {
    return this.authService.checkAuthStatus(user);
  }
}
